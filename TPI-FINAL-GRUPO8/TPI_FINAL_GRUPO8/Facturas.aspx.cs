using Dominio;
using Negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TPI_FINAL_GRUPO8.Servicios;
using System.Configuration;

namespace TPI_FINAL_GRUPO8
{
    public partial class Facturas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Usuario usuario = Session["usuarioLogueado"] as Usuario;
            if (usuario == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if(!IsPostBack)
            {
                Venta venta = null;
                int idVenta;

                if (int.TryParse(Request.QueryString["Id"], out idVenta))
                {
                    VentaNegocio negocio = new VentaNegocio();
                    venta = negocio.obtnerId(idVenta);
                }
                else
                {
                    venta = Session["VentaFactura"] as Venta;
                }
                if (venta == null)
                {
                    Response.Redirect("Ventas.aspx", false);
                    return;
                }
                // buscar al cliente

                if (venta.Cliente != null && venta.Cliente.Id > 0)
                {
                    ClienteNegocio clienteNegocio = new ClienteNegocio();
                    Cliente cliente = clienteNegocio.listarId(venta.Cliente.Id.ToString());
                    if (cliente != null && cliente.Id > 0)
                    {
                        venta.Cliente = cliente;
                    }
                }
                lblNroFactura.Text = venta.NroFactura;
                lblFecha.Text = venta.Fecha.ToString();
                lblTotal.Text = venta.Total.ToString("C2");

                if (venta.Cliente != null)
                {
                    lblNombreCliente.Text = (venta.Cliente.Nombre + " " + venta.Cliente.Apellido);
                    lblDni.Text = venta.Cliente.Dni;
                }

                if (idVenta > 0)
                {
                    DetalleVentaNegocio detalleNegocio = new DetalleVentaNegocio();
                    gvDetalleVenta.DataSource = detalleNegocio.listarPorVenta(idVenta);
                    gvDetalleVenta.DataBind();
                }
                else if (venta.Detalle != null)
                {
                    gvDetalleVenta.DataSource = venta.Detalle;
                    gvDetalleVenta.DataBind();
                }
                if (venta.Anulado)
                {
                    lblEstadoAnulada.Visible = true;
                }
            }

        }

        protected void btnMostrarCorreo_Click(object sender, EventArgs e)
        {
            lblMensajeCorreo.Text = "";
            lblMensajeCorreo.CssClass = "text-danger d-block mb-3";

            if (pnlEnviarCorreo.Visible)
            {
                pnlEnviarCorreo.Visible = false;
                return;
            }

            try
            {
                Venta venta;
                int idVenta;

                if (int.TryParse(Request.QueryString["Id"], out idVenta)
                    && idVenta > 0)
                {
                    VentaNegocio negocio = new VentaNegocio();
                    venta = negocio.obtnerId(idVenta);
                }
                else
                {
                    venta = Session["VentaFactura"] as Venta;
                }

                if (venta == null || venta.Cliente == null
                    || venta.Cliente.Id <= 0)
                {
                    lblMensajeCorreo.Text =
                        "No se encontró el cliente de esta factura.";
                    return;
                }

                // Recuperar el correo actualizado desde Clientes.
                ClienteNegocio clienteNegocio = new ClienteNegocio();
                Cliente cliente = clienteNegocio.listarId(
                    venta.Cliente.Id.ToString());

                if (cliente == null || cliente.Id <= 0
                    || string.IsNullOrWhiteSpace(cliente.Email))
                {
                    lblMensajeCorreo.Text =
                        "El cliente no tiene un correo cargado. Completalo en Clientes.";
                    return;
                }

                txtCorreoDestino.Text = cliente.Email.Trim();
                pnlEnviarCorreo.Visible = true;
            }
            catch (Exception ex)
            {
                Trace.Warn("FacturaCorreo",
                    "Error al cargar el destinatario.", ex);

                lblMensajeCorreo.Text =
                    "No se pudo cargar el correo del cliente. Intentá nuevamente.";
            }
        }

        protected void btnEnviarCorreo_Click(object sender, EventArgs e)
        {
            lblMensajeCorreo.Text = "";
            lblMensajeCorreo.CssClass = "text-danger d-block mb-3";

            try
            {
                string usuario = ConfigurationManager.AppSettings["Correo.UsuarioSmtp"];
                string clave = ConfigurationManager.AppSettings["Correo.ClaveSmtp"];

                if (string.IsNullOrWhiteSpace(usuario)
                    || string.IsNullOrWhiteSpace(clave))
                {
                    lblMensajeCorreo.Text =
                        "Falta configurar el usuario y la clave de Mailtrap.";
                    return;
                }

                Venta venta;
                int idVenta;

                if (int.TryParse(Request.QueryString["Id"], out idVenta)
                    && idVenta > 0)
                {
                    VentaNegocio negocio = new VentaNegocio();
                    venta = negocio.obtnerId(idVenta);
                }
                else
                {
                    venta = Session["VentaFactura"] as Venta;
                }

                if (venta == null || venta.Cliente == null
                    || venta.Cliente.Id <= 0)
                {
                    lblMensajeCorreo.Text =
                        "No se encontró la factura o su cliente.";
                    return;
                }

                ClienteNegocio clienteNegocio = new ClienteNegocio();
                Cliente cliente = clienteNegocio.listarId(
                    venta.Cliente.Id.ToString());

                if (cliente == null || cliente.Id <= 0
                    || string.IsNullOrWhiteSpace(cliente.Email))
                {
                    lblMensajeCorreo.Text =
                        "El cliente no tiene un correo cargado.";
                    return;
                }

                string destino = cliente.Email.Trim();

                // Si el correo cambió, pedir que se revise nuevamente.
                if (!string.Equals(destino, txtCorreoDestino.Text.Trim(),
                    StringComparison.OrdinalIgnoreCase))
                {
                    txtCorreoDestino.Text = destino;
                    lblMensajeCorreo.Text =
                        "El correo del cliente cambió. Revisalo antes de enviar.";
                    return;
                }

                venta.Cliente = cliente;

                FacturaPdf generador = new FacturaPdf();
                byte[] archivoPdf = generador.Generar(venta);

                string asunto = "Factura " + venta.NroFactura
                    + " - Gestión Comercial";

                string cuerpo =
                    "<p>Hola " + HttpUtility.HtmlEncode(cliente.Nombre) + ":</p>"
                    + "<p>Adjuntamos el comprobante de tu compra.</p>"
                    + "<p>Saludos,<br>Gestión Comercial</p>";

                using (EmailService servicio = new EmailService(usuario, clave))
                {
                    servicio.armarCorreo(destino, asunto, cuerpo);

                    servicio.adjuntarPdf(
                        archivoPdf, "Factura-" + venta.NroFactura + ".pdf");

                    servicio.enviarEmail();
                }

                pnlEnviarCorreo.Visible = false;
                lblMensajeCorreo.CssClass = "text-success d-block mb-3";
                lblMensajeCorreo.Text =
                    "El correo se envió a Mailtrap con el PDF adjunto.";
            }
            catch (Exception ex)
            {
                Trace.Warn("FacturaCorreo", "Error al enviar la factura.", ex);

                lblMensajeCorreo.Text =
                    "No se pudo enviar el correo. Revisá la configuración e intentá nuevamente.";
            }
        }

        protected void btnDescargarPdf_Click(object sender, EventArgs e)
        {
            lblErrorPdf.Text = "";

            Venta venta;
            byte[] archivoPdf;

            try
            {
                int idVenta;

                if (int.TryParse(Request.QueryString["Id"], out idVenta)
                    && idVenta > 0)
                {
                    VentaNegocio negocio = new VentaNegocio();
                    venta = negocio.obtnerId(idVenta);
                }
                else
                {
                    venta = Session["VentaFactura"] as Venta;
                }

                if (venta == null)
                {
                    lblErrorPdf.Text = "No se encontró la factura para descargar.";
                    return;
                }

                FacturaPdf generador = new FacturaPdf();
                archivoPdf = generador.Generar(venta);
            }
            catch (Exception ex)
            {
                Trace.Warn("FacturaPdf", "Error al generar el PDF.", ex);

                lblErrorPdf.Text =
                    "No se pudo generar el PDF. Intentá nuevamente.";
                return;
            }

            string nombreArchivo = Uri.EscapeDataString(
                "Factura-" + venta.NroFactura + ".pdf");

            Response.Clear();
            Response.BufferOutput = true;
            Response.ContentType = "application/pdf";

            Response.AddHeader(
                "Content-Disposition",
                "attachment; filename=\"" + nombreArchivo + "\"");

            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetNoStore();

            Response.BinaryWrite(archivoPdf);
            Response.Flush();

            Response.SuppressContent = true;
            Context.ApplicationInstance.CompleteRequest();
        }
    }
}
