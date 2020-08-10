class BadgeService
  def initialize(test_passage)
    @test_passage = test_passage
    @user = test_passage.user
    @test = test_passage.test
  end

  def badges
    Badge.all.select do |badge|
      badge if send(badge.rule_name, badge)
    end
  end

  private

  def all_test_from_category(badge)
    return false unless badge.category == @test.category
    return false unless @test_passage.successful

    if @user.badges.where(id: badge.id).exists?
      last_badge_created = UsersBadge.where(user: @user, badge: badge).order(created_at: :asc).last.created_at
      return Test.tests_success(@user)
                 .where(tests: { category: badge.category })
                 .where('test_passages.created_at > ?', last_badge_created)
                 .distinct.length == badge.category.tests.length
    end

    Test.tests_success(@user).where(tests: { category: badge.category }).distinct.length == badge.category.tests.length
  end

  def test_with_one_attempt(badge)
    return false unless badge.test == @test
    return false unless @test_passage.successful

    TestPassage.user_tests(badge.test, @user).count <= 1
  end

  def all_test_with_level(badge)
    return false unless @test.level.to_s == badge.rule_parameter
    return false unless @test_passage.successful

    level_tests = Test.where(level: badge.rule_parameter)
    return false if level_tests.length.zero?

    if @user.badges.where(id: badge.id).exists?
      last_badge_created = UsersBadge.where(user: @user, badge: badge).order(created_at: :asc).last.created_at
      return Test.tests_success(@user)
                 .where(tests: { level: badge.rule_parameter })
                 .where('test_passages.created_at > ?', last_badge_created)
                 .distinct.length == badge.category.tests.length
    end

    Test.tests_success(@user).where(tests: { level: badge.rule_parameter }).distinct.length == level_tests.length
  end
end
