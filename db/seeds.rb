# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# Make.create(name: 'HP')
# Make.create(name: 'Lenovo')
# Make.create(name: 'Ciara')

# PageType.create(name: 'Production')
# PageType.create(name: 'Cataloguing')
# PageType.create(name: 'Models')
# PageType.create(name: 'Misc')

# ModelType.create(name: 'Desktop')
# ModelType.create(name: 'Laptop')
# ModelType.create(name: 'Server')
# ModelType.create(name: 'Printer')
# ModelType.create(name: 'Other')

# Page.create(title: "Test", content: "valuable content", page_type_id: 2)

# Model.create(name: '6570b', series: 'i-series', make_id: 1, model_type_id: 2, page_id: 1)
# Model.create(name: '8005', series: 'Dual-core', make_id: 1, model_type: 1)

# UserLevel.create(name: 'Intern')
# UserLevel.create(name: 'Supervisor')
# UserLevel.create(name: 'Executive')

# User.create(email: 'one', encrypted_password: 'pass', user_type_id: 1)
# User.create(email: 'two', encrypted_password: 'pass', user_type_id: 1)
# User.create(email: 'three', encrypted_password: 'pass', user_type_id: 1)

# user = User.new
# user.email = 'one@example.com'
# user.password = 'valid_password'
# user.password_confirmation = 'valid_password'
# user.encrypted_password = '#$taawktljasktlw4aaglj'
# user.user_level_id = 1
# user.save!

# user = User.new
# user.email = 'two@example.com'
# user.password = 'valid_password'
# user.password_confirmation = 'valid_password'
# user.encrypted_password = '#$taawktljasktlw4aaglj'
# user.user_level_id = 1
# user.save!

# user = User.new
# user.email = 'three@example.com'
# user.password = 'valid_password'
# user.password_confirmation = 'valid_password'
# user.encrypted_password = '#$taawktljasktlw4aaglj'
# user.user_level_id = 1
# user.save!

# User.delete_all
# Page.delete_all
# PageType.delete_all
# ApprovalStatus.delete_all
# UserLevel.delete_all

# UserLevel.destroy_all
# ApprovalStatus.destroy_all
# Page.destroy_all
# User.destroy_all

UserLevel.create(level: INTERN_NAME)
UserLevel.create(level: SUPERVISOR_NAME)
UserLevel.create(level: EXECUTIVE_NAME)

Category.create(name: 'Production')
Category.create(name: 'Cataloguing')
Category.create(name: 'Backdoor')
Category.create(name: 'Computer Guides')

# a = Category.create(:name => "a")
# b = Category.create(:name => "b")
# c = Category.create(:name => "c", :parent => b)
# d = Category.create(:name => "d", :parent => b)
# e = Category.create(:name => "e", :parent => c)

ApprovalStatus.create(status: 'Pending')
ApprovalStatus.create(status: 'Supervisor Approved')
ApprovalStatus.create(status: 'Executive Approved')
ApprovalStatus.create(status: 'Rejected')

User.create(username: 'Executive Director', password: 'password', password_confirmation: 'password', user_level_id: EXECUTIVE_VALUE)
User.create(username: 'hpotter', password: 'password', password_confirmation: 'password', user_level_id: SUPERVISOR_VALUE)
User.create(username: 'jlennon', password: 'password', password_confirmation: 'password', user_level_id: SUPERVISOR_VALUE)
User.create(username: 'smireault', password: 'password', password_confirmation: 'password', user_level_id: INTERN_VALUE)

# Page.create(title: 'test1', content: 'test1', user_id: 3, approval_status_id: PENDING, category_id: 1)
# Page.create(title: 'test2', content: 'test2', user_id: 3, approval_status_id: PENDING, category_id: 1)
# Page.create(title: 'test3', content: 'test3', user_id: 3, approval_status_id: PENDING, category_id: 2)





