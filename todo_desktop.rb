## Global methods
def clear_screen
  system('reset')
end

def prompt(prompt_text)
  puts prompt_text
  choice = gets.chomp
end

## Classes
class Task
  attr_accessor :name, :status
  @@list_of_tasks = []

  def initialize(name, status = false)
    @name = name
    @status = status
  end

  ## Instance methods:
  def done?
    @status == true
  end

  ## Class methods:
  def self.index
    clear_screen
    puts "Your list contains following tasks:"
    @@list_of_tasks.each_with_index do |task, index|
      if task.done?
        puts "done     | #{index+1}. #{task.name}"
      else
        puts "not done | #{index+1}. #{task.name}"
      end
    end
  end

  def self.delete_task
    clear_screen
    Task.index
    @@list_of_tasks.delete_at(prompt("Which task do you want to delete?").to_i-1)
    clear_screen
  end

  def self.change_status
    clear_screen
    Task.index
    task = @@list_of_tasks[prompt("Which task do you want to change?").to_i-1]
    if task.done?
      task.status = false
    else
      task.status = true
    end
    clear_screen
  end

  def self.add_task
    clear_screen
    task = Task.new(prompt("Task name:"))
    @@list_of_tasks << task
    puts 'Task has been created.'
  end

  ## Development features
  def self.create_dummy_data
    data = ['Take the trash out',
            'Replace leds in the kitchen',
            'Clean up my room',
            'Love Karolina',
            'Write g00d code',
            'COFFEE!']

    data.each do |d|
      task = Task.new(d)
      @@list_of_tasks << task
    end
  end
end

################################################################################
## Program execution:
clear_screen
Task.create_dummy_data

while true
  Task.index
  puts '
    Menu:
    1. Add task
    2. Delete task
    3. Change task status
  '
  print '> '
  choice = gets.chomp.to_i

  case choice
  when 1
    Task.add_task
  when 2
    Task.delete_task
  when 3
    Task.change_status
  when 4

  when 0
    clear_screen
    puts "Goodbye! Thank you for choosing Platformatec."
    exit
  else
    runtime
  #   #
  # clear_screen
  end
end
