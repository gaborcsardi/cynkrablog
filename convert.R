posts <- fs::dir_ls("../cynkraweb/www/_posts")

register_post <- function(path) {
  cli::cli_text("Copying files for {.path {folder_name}}")
  folder_name <- path |>
    fs::path_file() |>
    fs::path_ext_remove()
  fs::dir_create(file.path("posts", folder_name))
  fs::dir_copy(path, file.path("posts", folder_name, "index.qmd"))

  images_folder <- file.path("../cynkraweb/www/blog", folder_name)
  if (fs::dir_exists(images_folder)) {
    cli::cli_text("Copying images for {.path {folder_name}}")
    fs::file_copy(
      fs::dir_ls(images_folder),
      file.path("posts", folder_name)
    )
  }
}

purrr::walk(posts, register_post)
