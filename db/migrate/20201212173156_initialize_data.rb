class InitializeData < ActiveRecord::Migration[6.0]
  def change
    UserLevel.create(level: INTERN_NAME)
    UserLevel.create(level: SUPERVISOR_NAME)
    UserLevel.create(level: EXECUTIVE_NAME)

    UserStatus.create(status: 'Active')
    UserStatus.create(status: 'Inactive')

    Category.create(name: 'Production')
    Category.create(name: 'Inventory')
    Category.create(name: 'Policy')
    Category.create(name: 'Computer Guides')

    ApprovalStatus.create(status: 'Pending')
    ApprovalStatus.create(status: 'Supervisor Approved')
    ApprovalStatus.create(status: 'Executive Approved')
    ApprovalStatus.create(status: 'Rejected')

    PagePublishStatus.create(status: 'Published')
    PagePublishStatus.create(status: 'Unpublished')

    User.create(first_name: 'Steph', last_name: 'Mireault', username: 'smireault', password: 'roguesyrissel1D4', password_confirmation: 'roguesyrissel1D4', user_level_id: EXECUTIVE_VALUE, user_status_id: UserStatus.find_by_status('Active').id)
    User.create(first_name: 'Guest', last_name: 'User', username: 'guest', password: 'password2020', password_confirmation: 'password2020', user_level_id: INTERN_VALUE, user_status_id: UserStatus.find_by_status('Active').id)
  end
end
