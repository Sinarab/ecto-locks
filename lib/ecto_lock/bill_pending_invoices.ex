defmodule EctoLock.BillPendingInvoices do
  require Logger
  alias EctoLock.{Invoice, Repo}

  def create_pending_invoice() do
    %Invoice{}
    |> Invoice.changeset(%{pending: true})
    |> Repo.insert()
  end

  def bill_pending_invoices(locking?) do
    Invoice.pending()
    |> Repo.all()
    |> Enum.each(fn invoice -> bill_pending_invoices(invoice.id, locking?) end)
  end

  def bill_pending_invoices(invoice_id, locking?) do
    invoice = get_invoice(invoice_id, locking?)
    bill_trought_api(invoice)
    mark_invoice_sent(invoice)
  end

  def get_invoice(invoice_id, locking?) do
    if locking? do
      Invoice
      |> Invoice.get_and_lock_invoice(invoice_id)
      |> Repo.one()
    else
      # this way we are not locking the invoice; likely to error
      Repo.get(Invoice, invoice_id)
    end
  end

  def bill_trought_api(invoice) do
    Logger.info("Sending invoice #{invoice.id}...")
    :timer.sleep(1000)
    Logger.info("Invoice #{invoice.id} sent!")
  end

  def mark_invoice_sent(invoice) do
    invoice
    |> Invoice.changeset(%{pending: false})
    |> Repo.update()
  end
end
