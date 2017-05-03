module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def guest_user
      #we need this becasue we'll get an error if no one is signed in 
      #so we create a guest user to take care of that just for ActionCable
      #we change the guest user model to have an id
      guest = GuestUser.new
      guest.id = guest.object_id #object_id is a value stored in memory each time an object is created
                                #we're using it to mimic an id that is required by warden
      guest.name = "Guest User"
      guest.first_name = "Guest"
      guest.last_name = "User"
      guest.email = "guest@user.com"
      guest
    end

    def connect
      self.current_user = find_verified_user || guest_user
      # Add logger if we need to see what's happening in the terminal
      logger.add_tags 'ActionCable', current_user.email
      logger.add_tags 'ActionCable', current_user.id
    end

    protected

    def find_verified_user
      #devise warden keeps track of users - we use it here to be able to
      #see if we have a verified user because ActionCable cannot directly access the user
      #data instance - it has a different connection point than the HTML connection
      #the syntax below returns the verified user only if the warden env says that user exists
      if verified_user = env['warden'].user
        verified_user
      end
  end
  end
end
