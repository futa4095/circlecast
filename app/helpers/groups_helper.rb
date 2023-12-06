# frozen_string_literal: true

module GroupsHelper
  def description_too_long?(description)
    description_lines = description.lines.count
    description_lines > DESCRIPTION_THRESHOLD_LINES
  end

  DESCRIPTION_THRESHOLD_LINES = 6
end
