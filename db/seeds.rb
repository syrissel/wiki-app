# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


UserLevel.create(level: INTERN_NAME)
UserLevel.create(level: SUPERVISOR_NAME)
UserLevel.create(level: EXECUTIVE_NAME)

UserStatus.create(status: 'Active')
UserStatus.create(status: 'Inactive')

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

PagePublishStatus.create(status: 'Published')
PagePublishStatus.create(status: 'Unpublished')

Setting.create(logo: 'Computers for Schools')

User.create(username: 'edirector', password: 'password', password_confirmation: 'password', user_level_id: EXECUTIVE_VALUE, user_status_id: UserStatus.find_by_status('Active').id)
User.create(username: 'hpotter', password: 'password', password_confirmation: 'password', user_level_id: SUPERVISOR_VALUE, user_status_id: UserStatus.find_by_status('Active').id)
User.create(username: 'jlennon', password: 'password', password_confirmation: 'password', user_level_id: SUPERVISOR_VALUE, user_status_id: UserStatus.find_by_status('Active').id)
User.create(username: 'smireault', password: 'password', password_confirmation: 'password', user_level_id: INTERN_VALUE, user_status_id: UserStatus.find_by_status('Active').id)

# Page.create(title: 'test1', content: 'test1', user_id: 3, approval_status_id: PENDING, category_id: 1)
# Page.create(title: 'test2', content: 'test2', user_id: 3, approval_status_id: PENDING, category_id: 1)
# Page.create(title: 'test3', content: 'test3', user_id: 3, approval_status_id: PENDING, category_id: 2)





