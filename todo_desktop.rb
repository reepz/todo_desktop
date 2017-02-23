def clear_screen
  system('cls')
end
################################################################################
class Task
  attr_accessor :name, :status
  @@list_of_tasks = []

  def initialize(name, status = false)
    @name = name
    @status = status
  end

  def done?
    @status == true
  end

  def self.delete_task
    clear_screen
    puts "Which task do you want to delete?"
    @@list_of_tasks.each_with_index do |task, index|
      if task.done?
        puts "#{index+1}. #{task.name} | done"
      else
        puts "#{index+1}. #{task.name} | not done"
      end
    end
    choice = gets.chomp.to_i
    @@list_of_tasks.delete_at(choice-1)
    clear_screen
  end

  def self.change_status
    clear_screen
    puts 'Which task you want to change:'
    @@list_of_tasks.each_with_index do |task, index|
      if task.done?
        puts "#{index+1}. #{task.name} | done"
      else
        puts "#{index+1}. #{task.name} | not done"
      end
    end
    choice = gets.chomp.to_i
    task = @@list_of_tasks[choice-1]
    if task.done?
      task.status = false
    else
      task.status = true
    end
    clear_screen
  end

  def self.add_task
    clear_screen
    print 'Task name: '
    name = gets.chomp
    task = Task.new(name)
    @@list_of_tasks << task
    puts 'Task has been created.'
  end

  def self.index
    clear_screen
    puts "You list contains following tasks:"
    @@list_of_tasks.each do |task|
      if task.done?
        puts "#{task.name} | done"
      else
        puts "#{task.name} | not done"
      end
    end
  end

  def self.create_dummy_data
    task = Task.new('Evolve')
    @@list_of_tasks << task

    task = Task.new('Conquer')
    @@list_of_tasks << task

    task = Task.new('Breed')
    @@list_of_tasks << task
  end

end

################################################################################
clear_screen
Task.create_dummy_data

while true
  puts '
    Menu:
    1. Add task
    2. Display all tasks
    3. Change task status
    4. Delete task
  '
  print '> '
  choice = gets.chomp.to_i

  case choice
  when 1
    Task.add_task
  when 2
    Task.index
  when 3
    Task.change_status
  when 4
    Task.delete_task
  when 0
    clear_screen
    print 'Thanks for choosing Platformtec.'
    exit
  else
    #
  clear_screen
  end
end
