% Meal numbers 
x = ["Breakfast" "Lunch" "Dinner" "Snacks"];
x1 = [1 2 3 4]; 


days = 3;  % Track only 3 days
totalCaloriesConsumed = zeros(1, days); 
totalCaloriesBurned = zeros(1, days); 

% Loop for each day
for day = 1:days
    % Get calorie inputs from user for each meal
    breakfastCalories = input('How many calories did you consume for Breakfast: ');
    lunchCalories = input('How many calories did you consume for Lunch: ');
    dinnerCalories = input('How many calories did you consume for Dinner: ');
    snackCalories = input('How many calories did you consume for Snack: ');

    %total calories consumed for the day
    y = [breakfastCalories lunchCalories dinnerCalories snackCalories];
    totalCaloriesConsumed(day) = sum(y);

    % Display
    disp(['Total calories consumed on Day ' num2str(day) ': ' num2str(totalCaloriesConsumed(day))]);
    totalCaloriesBurnedDay = 0;

    % Ask the user if they want to log activities for this day
    logActivities = true;

    % Start logging activities for the day
    while logActivities
        % List of activities
        activities = {'Baseball','Basketball','Biking','Climbing','Football','Hiking','Kayaking','Mowing','Running','Shoveling Snow','Skateboarding','Soccer','Swimming','Tennis','ULTIMATE FRISBEE','Volleyball','Walking','Weight Lifting'};

        % User selects activity
        [choice, ~] = listdlg('ListString', activities, 'Name', 'What activity are you logging?', 'ListSize', [400, 400]);

        % User inputs exercise time and weight
        timecell = inputdlg('How many minutes were you exercising for?');
        time = str2double(timecell);
        weightcell = inputdlg('What is your weight in pounds?');
        weight = str2double(weightcell);

        % MET values for each activity
        METs = [5, 8, 11, 8, 8.5, 7, 5, 5.5, 13.25, 6, 5, 9, 7, 7, 8, 8, 5, 6];

        % Pull the MET value for the chosen activity
        MET = METs(choice);

        % Convert weight to kg and calculate calories burned
        kg = 0.45359237 * weight / 9.81;
        caloriesBurned = MET * 3.5 * kg * time / 200;
        
        % Add the calories burned to the total for the day
        totalCaloriesBurnedDay = totalCaloriesBurnedDay + caloriesBurned;

        % Ask if the user wants to log another activity
        yesnt = {'Yes', 'No'};
        [yn, ~] = listdlg('ListString', yesnt, 'Name', 'Would you like to log another activity?');
        
        if yn == 2  % If "No" is selected, stop logging activities for this day
            logActivities = false;
        end
    end

    % Store total calories burned for the day
    totalCaloriesBurned(day) = totalCaloriesBurnedDay;

    % Display total calories burned for the day
    disp(['Total calories burned on Day ' num2str(day) ': ' num2str(totalCaloriesBurned(day))]);
end

% Plot the graphs
figure(1)

% Subplot for the bar graph (Meals vs Calories)
subplot(2,1,1) 
bar(x, y, 'g');  % Bar graph for calories consumed by meal
xlabel('Meals')
ylabel('Calories')
title('Day 1 meals and calories')
ylim([0 2000]);  % Set the y-axis limit

% Subplot for the line graph (Calories Over Days)
subplot(2,1,2) 
daysArray = 1:days;
plot(daysArray, totalCaloriesConsumed, '-o', 'DisplayName', 'Calories Consumed');
hold on;
plot(daysArray, totalCaloriesBurned, '-x', 'DisplayName', 'Calories Burned');
xlabel('Days')
ylabel('Calories')
title('Calories Over Days')
legend('show')
xlim([0 days+1]);  
ylim([0 max([totalCaloriesConsumed, totalCaloriesBurned]) * 1.1]);  
grid on;
