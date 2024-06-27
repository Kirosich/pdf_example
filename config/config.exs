import Config

config :pdf_example, PdfExample.Gettext,
  default_locale: "en",
  locales: ~w(en ru)
