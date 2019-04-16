user_counts <- count(full_data,alc_user_status)
health_counts <- count(full_data,alc_user_status,HEALTH)
print(health_counts,n=nrow(health_counts)) # nrow counts number of rows exactly
print(user_counts)
