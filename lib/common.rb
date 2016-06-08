module Common
  extend ActiveSupport::Concern

  module ClassMethods
    def show_history(num)
      where("history_id IS NULL AND id =? OR history_id =? AND id != ?", num, num, num).order("id DESC").first
    end

    def list_comment_history(num,not_num)
      where("history_id IS NULL AND id =? XOR history_id =? AND id != ? AND id != ?",num,num,num, not_num).order("id DESC")
    end
  end

  def check_history?
    self.history_id.blank?
  end

  def get_object_table_name
    self.class.name.singularize.classify.constantize.table_name
  end

end
