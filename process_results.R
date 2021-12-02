library(dplyr)
library(chron)
library(Rmisc)
library(readr)
library(nlme)
library(xtable)
library(ordinal)
library(dplyr)
library(lmerTest)
library(geepack)
library(lme4)
library(dplyr)
library(tidyr)


data = read.csv("./results/results_table.csv")
data$Subject <- factor(data$Subject)
data$RMSE <- data$RMSE * 180/pi
data$RMSU <- data$RMSU * 180/pi
data$Dynamics <- factor(data$Dynamics, levels = c("1", "2", "3", "4"))


overall_summary_mean <-  aggregate(. ~ data$Dynamics, data=data[c(2:6, 11:18)], FUN=mean)
overall_summary_median <-  aggregate(. ~ data$Dynamics, data=data[c(2:6, 11:18)], FUN=median)
overall_summary_std <-  aggregate(. ~ data$Dynamics, data=data[2:6], FUN=sd)

steady_vs_unsteady <- c(1, 1, -1, -1)
dyn1_vs_dyn2 <- c(1, -1, 0, 0)
dyn3_vs_dyn4 <- c(0, 0, 1, -1)
contrasts(data$Dynamics) <- cbind(steady_vs_unsteady, dyn1_vs_dyn2, dyn3_vs_dyn4)

rmse_model <- lme(RMSE ~ Dynamics, random=~1|Subject, data=data)
summary(rmse_model)

rmsu_model <- lme(RMSU ~ Dynamics, random=~1|Subject, data=data)
summary(rmsu_model)

omega_model <- lme(X..omega_c. ~ Dynamics, random=~1|Subject, data=data)
summary(omega_model)

tau_model <- lme(X..tau.  ~ Dynamics, random=~1|Subject, data=data)
summary(tau_model)

vafu_model <- lme(VAF.u  ~ Dynamics, random=~1|Subject, data=data)
summary(vafu_model)

data_ss = data[data$Dynamics == "1" | data$Dynamics == "2", ]
kx_model <- lme(X.K_x.  ~ Dynamics, random=~1|Subject, data=data_ss)
summary(vafu_model)

kxdot_model <- lme(X.K_..dot.x...  ~ Dynamics, random=~1|Subject, data=data_ss)
summary(vafu_model)

kr_model <- lme( X.k_r. ~ Dynamics, random=~1|Subject, data=data_ss)
summary(vafu_model)



data_filtered = data[(data$Dynamics == 3) | (data$Dynamics == 4), c(1, 2, 4, 8)]
# data_filtered = data[c(1, 2, 4, 8)]


data_long <- gather(data_filtered, condition, measurement, VAF.u:VAF.u.Val., factor_key=TRUE)
data_long$condition <- factor(data_long$condition)
                    
vaf_u_val_model <- lme(measurement ~ condition + Dynamics,  random=~1|Subject, data=data_long)
                    
                    
                    
                    