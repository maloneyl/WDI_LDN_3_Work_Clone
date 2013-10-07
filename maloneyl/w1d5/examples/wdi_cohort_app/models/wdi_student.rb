require_relative "../lib/acts_as_gradeable"

class WdiStudent < Person

  include ActsAsGradeable

  def task_scores
    @task_scores ||= {}
  end

  def add_task_score(task_name, percentage)
    task_scores[task_name.to_sym] = percentage.to_f
  end

  def to_s
    "GRADE: #{overall_grade} (#{mean_score.round}%) | " + super
  end

  def <=> (other)
    other.mean_score <=> self.mean_score
  end

end