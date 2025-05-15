class SetDefaultStatusForJobCards < ActiveRecord::Migration[8.0]
  def up
    # Установим значение по умолчанию для новых записей
    change_column_default :job_cards, :status, "active"

    # Обновим все существующие записи, у которых status is NULL
    execute <<-SQL
      UPDATE job_cards#{' '}
      SET status = 'active'#{' '}
      WHERE status IS NULL
    SQL
  end

  def down
    change_column_default :job_cards, :status, nil
  end
end
