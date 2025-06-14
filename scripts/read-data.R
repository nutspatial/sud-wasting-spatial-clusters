# ==============================================================================
#                               DECRYPT INPUT DATA
# ==============================================================================

## ---- Decrypt and read nutrition data ----------------------------------------

input_data <- decrypt(
  expr = read.csv("data/raw/north-darfur-smart-survey.csv"),
  key = secret_key
)

# ============================== End of Workflow ===============================
