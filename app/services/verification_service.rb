module VerificationService
  def self.check_biometry(email, image)
    user = User.find_by(email: email&.downcase, image: image)

    if user && rand(100) > 10
      { status: 200, message: 'OK' }
    else
      { status: 401, message: 'No Autorizado' }
    end
  end
end
