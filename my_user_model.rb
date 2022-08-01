require_relative 'app_connection'

class User 
    def self.create(user_info)
        DBConnection.execute(<<-SQL)
          INSERT INTO
            users (firstname, lastname, age, password, email)
          VALUES
            ('#{user_info[:firstname]}', '#{user_info[:lastname]}',
            '#{user_info[:age]}', '#{user_info[:password]}', '#{user_info[:email]}')
        SQL
        DBConnection.last_insert_row_id
      end

      def self.all
        DBConnection.execute(<<-SQL)
          SELECT
            *
          FROM
            users
        SQL
      end

      def self.find(user_id)
        DBConnection.execute(<<-SQL, user_id)
            SELECT* FROM
                USERS
            WHERE
                id = ?
        SQL
        .first
      end  

      def self.update(user_id, attribute, value)
        DBConnection.execute(<<-SQL, user_id, attribute)
            UPDATE
                users
            SET
                #{attribute} = #{value}
            WHERE
                id = #{user_id}
        SQL
      end 

      def self.destroy(user_id)
        DBConnection.execute(<<-SQL, user_id)
            DELETE FROM
                users
            WHERE
                id = ? 

        SQL
      end 
       
end    

user1 = User.create(firstname: "Colin", lastname: "Doe", age: "25", password: "password", email: "bla")
user2 = User.create(firstname: "Jane", lastname: "Doe", age: "25", password: "password", email: "bla")
user3 = User.create(firstname: "Ted", lastname: "Doe", age: "25", password: "password", email: "bla")
print User.all
print User.find(1)
User.destroy(2)
print User.all
User.update(1, :firstname, 'COLIN')
print User.find(1)