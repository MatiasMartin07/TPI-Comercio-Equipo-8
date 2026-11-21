using Dominio;
using Negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TPI_FINAL_GRUPO8
{
    public partial class Facturas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
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
    }
}