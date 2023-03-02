library(tidyverse)
library(nlme)
library(mgcv)
library(lme4)
library(geepack)



aids <- read.csv("aids.csv")

aids %>% 
  count()


hist(aids$age, breaks=26)

aids %>%
  summarize(variable = "age", mean_age = mean(age), st_dev_age = sd(age), min_age = min(age), max_age = max(age))


hist(aids$week, breaks=40)

aids %>%
  summarize(variable = "week", mean_week = mean(week), st_dev_week = sd(week), min_week = min(week), max_week = max(week))




aids %>% 
  ggplot(aes(x = factor(gender))) +
  geom_bar() +
  labs(x = "GENDER")

aids %>%
  count(gender)

aids %>% 
  ggplot(aes(x = factor(treatment))) +
  geom_bar() +
  labs(x = "TREATMENT")

aids %>%
  count(treatment)

summary(aids)


summarize(aids, mean_)

aids <- aids %>%
  mutate(treatment = factor(treatment))

aids <- aids %>% 
  mutate(week_sqr = week^2) %>% 
  relocate(week_sqr, .after = week)


model_quadratic <- lme(log_cd4 ~ treatment * week + treatment * week_sqr + age + gender,
                         data = aids,
                         random = ~ week + week_sqr | id,
                         method = "REML")

summary(model_quadratic)



res_population <- residuals(model_quadratic, type = "response", level = 0)

tibble(r_star = res_population) %>% 
  ggplot(aes(x = r_star)) +
  geom_histogram(aes(y = stat(density)), bins = 14, color = "black", fill = "gray") +
  geom_function(fun = dnorm, color = "blue") +
  labs(x = "Residuals", y = "Density")

tibble(r_star = res_population) %>% 
  ggplot(aes(sample = r_star)) +
  geom_qq_line(color = "blue") +
  geom_qq(shape = 1) +
  labs(x = "Quantiles of Standard Normal", y = "Quantiles of Untransformed Residuals")


Sigma_i <- extract.lme.cov(model_quadratic, aids)
L_i <- t(chol(Sigma_i)) #block matrix of lower triangular Cholesky factors
res_transformed <- solve(L_i) %*% res_population

tibble(r_star = res_transformed) %>% 
  ggplot(aes(x = r_star)) +
  geom_histogram(aes(y = stat(density)), bins = 14, color = "black", fill = "gray") +
  geom_function(fun = dnorm, color = "blue") +
  labs(x = "Residuals", y = "Density")


tibble(r_star = res_transformed) %>% 
  ggplot(aes(sample = r_star)) +
  geom_qq_line(color = "blue") +
  geom_qq(shape = 1) +
  labs(x = "Quantiles of Standard Normal", y = "Quantiles of Transformed Residuals")


mu_hat <- fitted(model_quadratic, level = 0)
mu_hat_transformed <- solve(L_i) %*% mu_hat
abs_res_transformed <- abs(res_transformed)

tibble(x = mu_hat, y = res_population) %>% 
  ggplot(aes(x = x, y = y)) +
  geom_hline(yintercept = 0, linetype = "dashed") +
  geom_point(shape = 1) +
  geom_smooth(method = "loess", se = FALSE) +
  labs(x = "Untransformed Predicted Value", y = "Untransformed Residual")


tibble(x = mu_hat_transformed, y = res_transformed) %>% 
  ggplot(aes(x = x, y = y)) +
  geom_hline(yintercept = 0, linetype = "dashed") +
  geom_point(shape = 1) +
  geom_smooth(method = "loess", se = FALSE) +
  labs(x = "Transformed Predicted Value", y = "Transformed Residual")



tibble(x = mu_hat_transformed, y = abs_res_transformed) %>% 
  ggplot(aes(x = x, y = y)) +
  geom_hline(yintercept = 0.8, linetype = "dashed") +
  geom_point(shape = 1) +
  geom_smooth(method = "loess", se = FALSE) +
  labs(x = "Transformed Predicted Value", y = "Absolute Transformed Residual")


time <- aids$week
time_transformed <- solve(L_i) %*% time


tibble(x = time_transformed, y = abs_res_transformed) %>% 
  ggplot(aes(x = x, y = y)) +
  geom_hline(yintercept = 0.8, linetype = "dashed") +
  geom_point(shape = 1) +
  geom_smooth(method = "loess", se = FALSE) +
  labs(x = "Transformed Time", y = "Absolute Transformed Residual")



Variogram(model_quadratic,
          data = aids,
          form = ~ week | id,
          resType = "normalized") %>% 
  as_tibble() %>% 
  ggplot(aes(x = dist, y = variog)) +
  geom_hline(yintercept = 1, linetype = "dashed") +
  geom_point(shape = 1) +
  geom_smooth(method = "loess", se = FALSE, span = 0.3)


aids <- aids %>% 
  mutate(cd4_count = round(exp(log_cd4) - 1))


model1 <- glmer(cd4_count ~ treatment * week + treatment * week_sqr + age + gender + (1 | id),
                data = aids,
                family = poisson, 
                control = glmerControl(tol = 1e-12),
                nAGQ = 0, 
                na.action = na.omit)

summary(model1)

res_population <- residuals(model1, type = "response", level = 0)


tibble(r_star = res_population) %>% 
  ggplot(aes(x = r_star)) +
  geom_histogram(aes(y = stat(density)), bins = 200, color = "black", fill = "gray") +
  geom_function(fun = dnorm, color = "blue") +
  labs(x = "Residuals", y = "Density")

tibble(r_star = res_population) %>% 
  ggplot(aes(sample = r_star)) +
  geom_qq_line(color = "blue") +
  geom_qq(shape = 1) +
  labs(x = "Quantiles of Standard Normal", y = "Quantiles of Untransformed Residuals")


model_quadratic_reduced <- lme(log_cd4 ~ week + age + treatment : week + treatment : week_sqr,
                       data = aids,
                       random = ~ week + week_sqr | id,
                       method = "REML")

summary(model_quadratic_reduced)


library(tidyr)


curve(-0.000116 *x^2 + -0.0127 * x , 0, 40)
abline(curve(-0.000261 *x^2 + 0.00738 * x , 0, 40))



