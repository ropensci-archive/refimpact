# This file contains a script to generate the ref_tags dataset

tag_types <- ref_get("ListTagTypes")

tag_values <- vector("list", nrow(tag_types))
for (i in seq_along(tag_types$ID)) {
  tag_values[[i]] <- ref_get("ListTagValues", tag_types$ID[i])
  tag_values[[i]]$TypeID <- tag_types$ID[i]
  tag_values[[i]]$TagType <- tag_types$TagType[i]
}

ref_tags <- do.call("rbind", tag_values)

ref_tags <- iconv(ref_tags$Name, from = "UTF-8", to = "latin1")

devtools::use_data(ref_tags, overwrite = T)
saveRDS(ref_tags, "inst/extdata/ref_tags.rds")

rm(tag_types, tag_values, ref_tags)
