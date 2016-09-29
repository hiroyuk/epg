class TimetableController < ApplicationController

  def channels
    channels = Channel.all.map do |channel|
      {'id' => channel.id, 'name' => channel.name}
    end
    render :json => channels
  end

  def programs
    programs = Program.where('end > :t', t: Time.current).map do |program|
      {
          'id' => program.id,
          'start' => program.start.in_time_zone('Japan'),
          'end' => program.end.in_time_zone('Japan'),
          'resource' => program.channel_id,
          'text' => program.title,
          'bubbleHtml' => program.detail
      }
    end
    render :json => programs
  end

  def reservations
    reservations = []
    render :json => reservations
  end
end
