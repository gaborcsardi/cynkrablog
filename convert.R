posts <- fs::dir_ls("../cynkraweb/www/_posts")

register_post <- function(path) {
  folder_name <- path |>
    fs::path_file() |>
    fs::path_ext_remove()
  cli::cli_text("Copying files for {.path {folder_name}}")

  parent_folder <- file.path("blog", "posts", folder_name)

  fs::dir_create(parent_folder)
  fs::dir_copy(path, file.path(parent_folder, "index.qmd"))

  images_folder <- file.path("../cynkraweb/www/blog", folder_name)
  if (fs::dir_exists(images_folder)) {
    cli::cli_text("Copying images for {.path {folder_name}}")
    fs::file_copy(
      fs::dir_ls(images_folder),
      parent_folder
    )
  }
}

purrr::walk(posts, register_post)
