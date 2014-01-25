# encoding: utf-8

module PuzzlesHelper
  def status_icon(status, options = {})
    # See if we got passed a Puzzle object
    status = status.status if status.respond_to? :status

    image_tag case status
      when 'wip' then 'glyphicons/136_cogwheel.png'
      when 'needs_testing' then 'glyphicons/150_edit.png'
      when 'ready' then 'glyphicons/198_ok.png'
      else 'glyphicons/194_circle_question_mark.png'
      end, options
  end
end
