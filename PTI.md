## PTI

The PTI index is calculated in a separate Access database. It is a summation of the fraction each taxon contibutes to the total bio volume multiplied by a set optimum for each taxon. Then this sum is divided by the total bio volume fraction of those taxons that have an optimum set.

The taxon optimums are fetched from the table t_Species_optimum in Phytoplankton.accdb. Which is just the rubin_code and optimum.

## Nivadatabase calculation

Nivadatabase has a PTI calculation in the package Phytoplankton_calk. It is based on the optimum values in the table TAXONOMY_CODES_SCORES with score_type_id = 1.

We're actually calculating PTI even if it looks like we're using the one from the Access database. Then we should make sure it works and that we're having the correct optimum values set.

## Taxonomy_codes_scores trigger

There is a trigger on the table Nivadatabase.TAXONOMY_CODES_SCORES to update the PTI in the Nivadatabase.PHYTOPLANKTON_PARAMETER_VALUES table when a new score is set. It calls a procedure to recalculate PTI for all samples that have a plankton_sampled_values with the taxonomy_code_id that was changed. This procedure is in the package Phytoplankton_calk.
