defmodule PdfExample.HBD do
  import PdfExample.Gettext

  # Подается список вида [%{name: "A", sender: "B"}, %{name: "A", sender: "B"}, ...]
  # Нужно составить feed из template для каждого элемента в списке

  def styles() do
    """
    <meta charset="UTF-8">
    <style>
    /* http://meyerweb.com/eric/tools/css/reset/
    v2.0 | 20110126
    License: none (public domain)
    */

    html, body, div, span, applet, object, iframe,
    h1, h2, h3, h4, h5, h6, p, blockquote, pre,
    a, abbr, acronym, address, big, cite, code,
    del, dfn, em, img, ins, kbd, q, s, samp,
    small, strike, strong, sub, sup, tt, var,
    b, u, i, center,
    dl, dt, dd, ol, ul, li,
    fieldset, form, label, legend,
    table, caption, tbody, tfoot, thead, tr, th, td,
    article, aside, canvas, details, embed,
    figure, figcaption, footer, header, hgroup,
    menu, nav, output, ruby, section, summary,
    time, mark, audio, video {
    margin: 0;
    padding: 0;
    border: 0;
    font-size: 100%;
    font: inherit;
    vertical-align: baseline;
    }
    /* HTML5 display-role reset for older browsers */
    article, aside, details, figcaption, figure,
    footer, header, hgroup, menu, nav, section {
    display: block;
    }
    body {
    line-height: 1;
    }
    ol, ul {
    list-style: none;
    }
    blockquote, q {
    quotes: none;
    }
    blockquote:before, blockquote:after,
    q:before, q:after {
    content: '';
    content: none;
    }
    table {
    border-collapse: collapse;
    border-spacing: 0;
    }
    h1 {
      font-size:30px;
      color:red;
    }
    </style>
    """
  end

  def feed do
    """
    <%= @styles %>
    <ol>
      <%= for item <- @items do %>
        <li><%= item %></li>
      <% end %>
    </ol>
    """
  end

  def template do
    """
    <h1>#{gettext("Happy Birthday")}, <%= @name %>!</h1>
    <p><%= @birthday_text %></p>
    <p>#{gettext("From")}: <%= @sender %></p>
    """
  end

  def birthday_text1 do
    gettext("Happy birthday friend!")
  end

  def birthday_text2 do
    gettext("Big boy congrats")
  end

  def feed_render(birthday_assigns) do
    items =
      birthday_assigns
      |> Enum.map(fn item ->
        render(template, item)
      end)

    feed |> EEx.eval_string(assigns: %{items: items, styles: styles()})
  end

  def render(template, assigns \\ [name: "Антон", sender: "Саша"]) do
    template |> EEx.eval_string(assigns: assigns)
  end

  def save(html, file_name \\ "hbd.html") do
    File.write!(file_name, html)
  end
end
