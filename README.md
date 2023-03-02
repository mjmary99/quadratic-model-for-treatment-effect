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


