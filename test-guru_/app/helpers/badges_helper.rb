module BadgesHelper
  def generate_collection
    Badge.all.collect { |badge| [I18n.t("admin.badge.#{badge.rule_name}"), badge.rule_name] }
  end
end
