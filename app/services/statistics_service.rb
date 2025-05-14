class StatisticsService
  def initialize(user)
    @user = user
  end

  def job_cards_stats
    {
      completed: JobCard.where(user: @user, status: "completed").count,
      in_progress: JobCard.where(user: @user, status: "in_progress").count,
      pending: JobCard.where(user: @user, status: "pending").count
    }
  end

  def ratings_distribution
    Rating.where(rateable: @user).group(:grade).count
  end

  def monthly_jobs_stats
    JobCard.where(user: @user)
           .where("created_at > ?", 1.year.ago)
           .group_by_month(:created_at)
           .count
  end

  def average_rating_by_month
    Rating.where(rateable: @user)
          .where("created_at > ?", 1.year.ago)
          .group_by_month(:created_at)
          .average(:grade)
  end

  def top_locations
    JobCard.where(user: @user)
           .group(:location)
           .count
           .sort_by { |_, count| -count }
           .first(5)
           .to_h
  end

  def earnings_by_month
    JobCard.where(user: @user, status: "completed")
           .where("created_at > ?", 1.year.ago)
           .group_by_month(:created_at)
           .sum(:remuneration)
  end

  def job_applications_stats
    {
      accepted: JobApplication.where(user: @user, status: "accepted").count,
      pending: JobApplication.where(user: @user, status: "pending").count,
      rejected: JobApplication.where(user: @user, status: "rejected").count
    }
  end

  def work_amount_distribution
    JobCard.where(user: @user)
           .group(:work_amount)
           .count
           .sort_by { |amount, _| amount }
           .to_h
  end
end
