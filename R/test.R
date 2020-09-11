






# Initial Damage ----------------------------------------------------------

# Evaluate the damage of the raw spectrum (D_0)

# Evaluate the RMS and skewness of the original spectrum




# Spectrum Truncation -----------------------------------------------------

# Removes features from spectrum
# Filter out amplitudes below 10% of maximum, or maybe RMS



# Search 2D space ---------------------------------------------------------

# Using the rainflow spectrum of truncated spectrum,
# adjust the cycle amplitude scaling (x_A) and mean scaling (x_mu)
# to achieve same damage and maintain shape of spectrum as best as possible
# Similiarity determined by RMS, skewness, and maybe cross-correlation


# Constraint: f(x_A, x_mu) = D_0 -> Maintain damage
# Minimise: | Delta RMS |,
#           | Delta skewness |,
#           | Delta chi |






