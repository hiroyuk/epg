require 'date'
require 'json'
require 'open3'

module Epg
  class Loader

    def ts_to_json(file_name)
      cmd = %Q(epgdump json "#{file_name}" -)
      o, s = Open3.capture2(cmd)
      o
    end

    def load(json_data)
      epg_data = JSON.load(json_data)

      ApplicationRecord.transaction do
        epg_data.each do |ch|
          channel = Channel.find_or_initialize_by(original_id: ch['id'])

          channel.update_attributes(
              :original_id => ch['id'],
              :transport_stream_id => ch['transport_stream_id'],
              :original_network_id => ch['original_network_id'],
              :service_id => ch['service_id'],
              :name => ch['name']
          )
        end

        epg_data.map { |ch| ch['programs'] }.flatten.each do |pg|
          program = Program.find_or_initialize_by(original_id: pg['event_id'])

          program.update_attributes(
              :original_id => pg['event_id'],
              :channel => Channel.find_by(original_id: pg['channel']),
              :title => pg['title'],
              :detail => pg['detail'],
              :start => Time.at(pg['start'] / 10000).to_datetime,
              :end => Time.at(pg['end'] / 10000).to_datetime,
              :duration => pg['duration']
          )
        end
      end
    end

    def delete_old_program
      limit = Time.current - 1.day
      Program.where(['end < ?', limit]).delete_all
    end
  end
end