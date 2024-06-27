defmodule PdfExample.Run do
  import PdfExample.HBD
  import PdfExample.Gettext

  def generate_pdf() do
    Mix.Task.run("gettext.extract")
    Mix.Task.run("gettext.merge")

    birthday_assigns = [
      %{name: "Ilya", sender: "Makt", birthday_text: PdfExample.HBD.birthday_text1()},
      %{name: "Yams", sender: "Yomt", birthday_text: PdfExample.HBD.birthday_text2()}
    ]

    en_html = PdfExample.HBD.feed_render(birthday_assigns)

    {:ok, en_filename} =
      PdfGenerator.generate(en_html,
        page_size: "A4",
        shell_params: ["--dpi", "300"]
      )

    Gettext.put_locale(PdfExample.Gettext, "ru")

    ru_html = PdfExample.HBD.feed_render(birthday_assigns)

    {:ok, ru_filename} =
      PdfGenerator.generate(ru_html,
        page_size: "A4",
        shell_params: ["--dpi", "300"]
      )

    File.rename(en_filename, "./birthday_list_en.pdf")
    File.rename(ru_filename, "./birthday_list_ru.pdf")
  end
end
