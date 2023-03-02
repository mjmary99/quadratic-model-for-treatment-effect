# quadratic-model-for-treatment-effect

This project mainly compares the effect of treatment types on the changes in log transformed CD4 counts over time based on the records of AIDS patients. The dataset we are studying is an AIDS Clinical Trial. It measures the corresponding CD4 counts (response variable) of AIDS patients with certain different advanced immune suppression treatment across the time. The model we will be using is the LME Quadratic Transformed Model, and this model works better than Linear model, Piecewise Linear model, untransformed model, or GLME model.

The quadratic model shows that while age and observation week have a high correlation with cd4, the 4 treatments all have quadratic relations between week and cd4 when group by different treatment. For each treatment, the quadratic equation between cd4 and week implies that there is a concave down curve that the cd4 first increase a little and then drop. Our result is showing that when Comparing the between the treatments, treatment 1 medication is the fastest to take effect for reducing the cd4 counts, while the treatment 4 medication has the greatest decreasing rate of cd4 counts.

## Exploratory Data Analysis

The dataset we are analyzing comes from a randomized, double-blind, AIDS Clinical Trial study. There are totally 1309 patients participated in this study, and each of them have their distinct id number. The data records the CD4 counts (response variable) of these AIDS patients with randomized to 4 different advanced immune suppression treatments, leading CD4 counts to less than or equal to 50 cells/mm3, over weeks.
Here are the advanced immune suppression treatments:
1. zidovudine alternating monthly with 400mg didanosine
2. zidovudine plus 25mg of zalcitabine
3. zidovudine plus 400mg of didanosine
4. zidovudine plus 400mg of didanosine plus 400mg of nevirapine

Each of the immune suppression treatment includes a medication called Zidovudine. In the data set, the response variable CD4 counts is recorded in log transformed scale (log_cd4).
Aside from the response variable, we have four other covariates that are be used for the model of our analysis:

- Treatment (mentioned above)

- Week (time of weeks since baseline)

- Age (age of patients in years) 

- Gender (male and female)

Our goal for this study is to examine the effect of different advanced immune suppression treatment types on the changes in log transformed CD4 counts over weeks by using the
model that is most appropriate for this dataset. We create several models like linear, quadratic, piece-wise, GLS, LME and etc. Comparing these models with tools like hypothesis testing, residual plot, p-value, we would choose the model that fit the data most and apply it to analyze the effect of treatment on changing the CD4 counts.

#### Graphs of the relationship between variables
The number of each records in each treatment are approximately the same. The number of each observations in each gender is in the graph below. The number of records for male patients is approximately 8 times of the records for female patients.
<p align="center">
<img width="821" alt="Screen Shot 2023-03-02 at 12 36 32 AM" src="https://user-images.githubusercontent.com/61670089/222340689-b1bce703-9d81-4f18-8533-c33ea7f20ace.png">
</p>

The histogram distribution of the number of each observation for each age groups. The records for the age groups is somewhat skewed to right. This graph is the histogram distribution of the number of each observation based on the time each participate report their count of cd4. Since the required testing time was week 0, week 8, week 16, week 24, week 32, and week 40, the approximate distribution follows this pattern, which meant patients were trying to follow the timeline.
<p align="center">
<img width="824" alt="Screen Shot 2023-03-02 at 12 39 37 AM" src="https://user-images.githubusercontent.com/61670089/222340814-a44148a6-0fb4-481e-bf0a-083b55672167.png">
</p>
The distribution of the ages for each data record in each treatment group are approximately the same, and there does not exist a large variation between these four groups. The relationship between age and the recorded result of log_cd4, and the Overall trends of the response variable relative to other variables is showing below.
<p align="center">
<img width="825" alt="Screen Shot 2023-03-02 at 12 41 13 AM" src="https://user-images.githubusercontent.com/61670089/222341066-46c250a1-8e56-49da-a5da-eadb3d37256f.png">
</p>
By looking at the graph, the overall trend of the response variable is piecewise linear (spline) for all the treatments for the cross 40 weeks. Over these 40 weeks, we can see that the treatment 3 and 4 have obvious higher overall mean of the log transformed CD4 counts than those of the 2 other treatments. In addition, the treatment 2 and 4 seems to have the more extreme variability of the log transformed CD4 counts among these 4 treatments. The overall log transformed CD4 counts of these 4 treatments seem almost the same during week 0 and week 40.

#### Imbalance in the dataset
By looking at the dataset, we find that there are many imbalances inside. We can see that the maximum times of observation for each patient is 6 times, in average, which is 8 weeks per time since week 0. However, not all patients have 6 observations, because lots of patients missed some measurements. Some of them get 4 or 5 observations, and some of them even only get 1 observation (week 0). In addition, we can see the gender of participates also has the imbalance according to the univariate summary of gender. The number of the observation for male is obviously greater than that of female in the dataset.


#### Outliers in the dataset
There are outliers in the dataset. From the boxplot of treatment and log transformed CD4 counts below, we are able to see that there are obvious several outlier observations in each treatment. In addition, the maximum of the log transformed CD4 counts is 6.297, which is far from most of the data. Also, based on the Q-Q plot, there are outliers inside the graphs.
<p align="center">
<img width="796" alt="Screen Shot 2023-03-02 at 12 42 17 AM" src="https://user-images.githubusercontent.com/61670089/222341249-33d3ba06-46fe-4be3-98da-4dcaacf9b974.png">
</p>

## Model Expression
#### LME(linear mixed effects) Quadratic model
<p align="center">
<img width="828" alt="Screen Shot 2023-03-02 at 12 42 55 AM" src="https://user-images.githubusercontent.com/61670089/222341352-61c3053b-7ef5-4127-8ce9-f71c73f60bf6.png">
</p>
In this LME Quadratic model, we have 8 fixed coefficients in total, including the coefficient of different treatments, age of patients, gender of patients, number of weeks since baseline, square of weeks number, the interaction term between treatment type and week number, and the interaction term between treatment type and square of week number.
In addition, the model also includes three random subject effect for week number square of week number.

## Model Selection
#### Part 1: Why Selecting Quadratic But not Linear Model
<p align="center"><img width="886" alt="Screen Shot 2023-03-02 at 12 43 44 AM" src="https://user-images.githubusercontent.com/61670089/222341475-d0161c85-ef46-4a8a-853b-dc92fc54abc0.png">
</p>
since p-value is less than 0.0001 which is less than the significance level apha =0.05, we reject the null hypothesis and conclude that the Quadratic model is more appropriate for fitting this data when comparing to the quadratic model. Thus, we decide to use quadratic but not the linear one.

#### Part 2: Why Selecting Transformed Model But not Untransformed Model
Comparing the transformed and the untransformed residual histogram, since the distribution of untransformed residual is not normal, we prefer to use the transformed residual for analyzing.

The Q-Q plot does not display any systematic departures from a straight line. The quantile plot of the transformed residuals does have fat tails but with no very extreme observation. The tails are not lined straightly because we have outliers inside our dataset. The size of the outliers inside this Q-Q plot is related with the dataset’s outliers.

The scatterplots of the transformed predicted value vs transformed residual display no obvious systematic pattern, with a random scatter around a constant mean of zero. The gap in between is normal because we don’t have specific data in that period of predicted value.
Since the graphs of transformed model is more normal and fit than untransformed model, we need to use transformed model.

<p float="left">
 <img width="379" alt="Screen Shot 2023-03-02 at 12 44 23 AM" src="https://user-images.githubusercontent.com/61670089/222341704-8937ebc7-ffd6-4715-bdac-0931f498def4.png">
<img width="371" alt="Screen Shot 2023-03-02 at 12 44 35 AM" src="https://user-images.githubusercontent.com/61670089/222341706-1d2c51cd-f4ee-4713-93c5-b6c6cb0d45f5.png">
<img width="395" alt="Screen Shot 2023-03-02 at 12 44 43 AM" src="https://user-images.githubusercontent.com/61670089/222341708-6313bf81-9a1d-4099-8cb5-3ab51fab3a5a.png">
</p>

#### Part 3: Why Selecting LME Model But not GLME Model
To check the normality of these two models, we need to plot the Q-Q plots.
<p align="center">
<img width="827" alt="Screen Shot 2023-03-02 at 12 45 59 AM" src="https://user-images.githubusercontent.com/61670089/222342013-7feebfcf-baaf-48d8-afd0-ddcdca171d02.png">
</p>
Based on the Q-Q plots, we need to choose LME model.
According to the above three comparisons between different models, we need to choose transformed quadratic LME model, because it is a better fit.

## Data of the model

<p align="center">
<img width="861" alt="Screen Shot 2023-03-02 at 12 47 54 AM" src="https://user-images.githubusercontent.com/61670089/222342196-57798b1b-60f1-4d0d-a601-84a557c56d63.png">
<img width="649" alt="Screen Shot 2023-03-02 at 12 47 59 AM" src="https://user-images.githubusercontent.com/61670089/222342198-aafae8ad-fdd1-494f-819d-6890b40381c8.png">
</p>

By looking the p-values above, the we find that the most of the p-values of the coefficients are less than apha=0.05 expect for those of β2 (treatmenti), β4(square of week number) and β6 (gender) are obviously greater than apha=0.05. we then reject
 
the null hypothesis for these coefficients which means that these variables may not be that appropriate to be included in this model.

## Interpretation of the model
As previous hypothesis tests show, there are coefficients in the full model that are not significant to the variability of the response data. Thus, based on the hypothesis tests in previous, we further do a reduced model without β2 (treatmenti), β4(square of week number) and β6 (gender) and would find out that the AIC for the reduced model is smaller than the full model and the p-values for the coefficients are smaller than the significant level 0.05. Therefore, we interpret our model with the reduced version.

<p align="center">
<img width="774" alt="Screen Shot 2023-03-02 at 12 49 39 AM" src="https://user-images.githubusercontent.com/61670089/222342431-cdfa8958-3010-4e28-80cd-2791f2f06d71.png">
</p>

The reduced model is as follows:
<p align="center">
<img width="782" alt="Screen Shot 2023-03-02 at 12 50 08 AM" src="https://user-images.githubusercontent.com/61670089/222342475-77692e22-f087-4d29-8cee-1002436fb249.png">
</p>

The interpretation of the significant coefficients are as follows:

<p align="center">
<img width="828" alt="Screen Shot 2023-03-02 at 12 51 23 AM" src="https://user-images.githubusercontent.com/61670089/222342681-9e48f2b6-2f41-4046-b4fa-1326520bf239.png">
<img width="810" alt="Screen Shot 2023-03-02 at 12 51 28 AM" src="https://user-images.githubusercontent.com/61670089/222342683-563e355e-aeb5-4e9a-96ba-d6f3d55ece7b.png">
</p>

## Conclusion
The specific model with value is:
<p align="center">
<img width="818" alt="Screen Shot 2023-03-02 at 12 52 38 AM" src="https://user-images.githubusercontent.com/61670089/222342866-013da3d9-cc73-4ccf-a007-99a8dbb70a45.png">
</p>
Information implied from the model:

- The expected cd4 level in patients does not have a significant correlation with patients’ gender, different treatment alone, and square of observation week.

- The coefficient for week variable is negative which indicates that as the observation week increase the expected cd4 will decrease. This implies that those treatments do have effects on the patients, which is reasonable.

- The coefficient for age is positive which indicates for patients having other covariates being the same, the patient with elder age will have higher cd4. This also makes sense as elder people usually takes more time to cure.

- The coefficient for treatment:week and treatment: week^2 implies the quadratic relation between week and cd4 when group by different treatment.
Moreover, for each treatment, the quadratic equation between cd4 and week implies that there is a concave down curve that the cd4 first increase a little and then drop. This is also reasonable as many curing processes follows a concave down trend.

- Also, comparing the between the treatments, treatment 4 has the sharpest decreasing rate when it starts to drop, while treatment 1 start to decrease to cd4 the earliest among the 4 treatments.

- In other words, all four treatments seem to have the effect of lowing the cd4 counts for patients over weeks. The treatment 1 medication seems to be the fastest to take effect for reducing the cd4 counts, while the treatment 4 medication has the greatest decreasing rate of cd4 counts in certain period when comparing to other 3 treatments.

- There is also some limitation in our model. For example, we don’t have the treatment : age and treatment : gender to test if for some specific treatment there is a high correlation with age or gender that is different than the overall trend the 4 treatments showing together.


