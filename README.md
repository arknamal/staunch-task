# Assesement for Candidates applying for the position of SSE(ROR)

Please follow the instructions below to complete the tasks and showcase your proficiency in Ruby on Rails. This assesement will be focussed on refactoring and code optimization techniques.
## Prerequisites

Redis should be installed. You can use this tutorial to install redis `https://www.digitalocean.com/community/tutorials/how-to-install-and-secure-redis-on-ubuntu-22-04` or google some other guide according to the OS you are using

## Getting Started

1. **Clone the Repository:**
   - Clone this repository to your local machine using the following command:
     ```
     git clone <repository-url>
     ```

2. **Install Dependencies:**
   - Navigate to the project directory and run the following command to install the required gems:
     ```
     bundle install
     yarn install
     ```

3. **Database Setup:**
   - Set up the database by running the following commands:
     ```
     rails db:create
     rails db:migrate
     rails db:seed
     ```

4. **Run the Application:**
   - Start the Rails server:
     ```
     bin/dev
     ```
   - Open your browser and visit `http://localhost:3000` to see the application running.


## Tasks

### Optimization Task 1

- There is a `Blog` CRUD in the app and it also has an import action in `BlogsController` which takes a csv file and import all the records. The challenge is to optimize that action in a way that it takes file of 100k+ records and create blogs. You need to take care of memory and database optimization and make sure that it does not crash


### Optmization Task 2

- There is a `MemoryLeakJob` in the app. The task is to identify memory intensive chunks of the code and optimize it in a way that the job processes 100k+ records with minimal amount of memory. You should also take care of the memory in case multiple jobs are enqueued. 

### Task 3 - Optional and Open Ended

- Do a overall code audit and improve code quality of models, controller,views or any other aspect 

### Submission Instructions

- You are not allowed to push code to this repository. Therefore you are required to create a copy of this repository on your own account and work on it. Hint: Make good use of git clone, git fork, git plugins for vs code etc.

- You are required to to make Pull Requests for all the task related changes you will make which should contain the summary of the changes you made in the code and explanation of why that change was needed.

- Commit messages and Branch naming should be self explanatory

- You are required to send your created repository link back to the same email thread where you received this assessment and we will take care of the next steps. Respository on your account must be public for us to access.

- If you are making any assumption in code. Write that out , so we test that accordingly


## Evaluation Criteria

Candidates will be evaluated based on the following criteria:

- **Ruby on Rails Proficiency:** Demonstrated ability to work with models, controllers, views, and database interactions.
- **Code Quality:** Clean and well-organized code with proper comments where necessary.
- **Functionality:** Completion of the specified tasks and overall functionality of the application.
- **Creativity:** Extra points for innovative features or improvements beyond the basic requirements.
- **Documentation:** As mentioned in the Submission instructions the Pull Requests should have summary of related changes and why that change was required. All of this should be properly documented

Good luck! If you have any questions or need clarification, feel free to reach out.
