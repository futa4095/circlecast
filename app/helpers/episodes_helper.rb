# frozen_string_literal: true

module EpisodesHelper
  def publication_and_update_dates(episode)
    if episode.updated?
      publication_date(episode) + updated_date(episode)
    else
      publication_date(episode)
    end
  end

  private

  def publication_date(episode)
    "#{l episode.created_at.to_date}に公開"
  end

  def updated_date(episode)
    " (#{l episode.updated_at.to_date} に更新)"
  end
end
