module ActsAsGradeable

  def task_grade(task_name)
    score_to_grade task_scores[task_name.to_sym]
  end

  def overall_grade
    score_to_grade mean_score
  end

  def mean_score
    scores = task_scores.values
    total  = scores.inject(0.0) { |sum, el| sum + el }
    total / scores.size
  end

  private

  def score_to_grade(score)
    case score
    when 0..20   then "E"
    when 21..40  then "D"
    when 41..60  then "C"
    when 61..80  then "B"
    when 81..100 then "A"
    end
  end

end