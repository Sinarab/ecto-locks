defmodule EctoLock.BillPendingInvoices do
  require Logger
  alias EctoLock.{Invoice, Repo}

  def create_pending_invoice() do
    %Invoice{}
    |> Invoice.changeset(%{pending: true})
    |> Repo.insert()
  end

  def bill_pending_invoices() do
    Invoice.pending()
    |> Repo.all()
    |> Enum.each(fn invoice -> bill_pending_invoices(invoice.id) end)
  end

  def bill_pending_invoices(invoice_id) do
    invoice = get_invoice(invoice_id)
    bill_trought_api(invoice)
    mark_invoice_sent(invoice)
  end

  def get_invoice(invoice_id) do
    Repo.get(Invoice, invoice_id)
  end

  def bill_trought_api(invoice) do
    Logger.info("Sending invoice #{invoice.id}...")
    IO.puts("Sending invoice #{invoice.id}...")
    :timer.sleep(1000)
    IO.puts("Invoice #{invoice.id} sent!")
    Logger.info("Invoice #{invoice.id} sent!")
  end

  def mark_invoice_sent(invoice) do
    invoice
    |> Invoice.changeset(%{pending: false})
    |> Repo.update()
  end
end
