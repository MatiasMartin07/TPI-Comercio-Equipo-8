using Negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TPI_FINAL_GRUPO8
{
    public partial class HistorialVenta : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                VentaNegocio negocio = new VentaNegocio();
                gvVentas.DataSource = negocio.listar();
                gvVentas.DataBind();
            }
        }

        protected void gvVentas_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (string.IsNullOrEmpty(e.CommandArgument?.ToString()))
                return;
            int idVenta = Convert.ToInt32(e.CommandArgument); ;

            if (e.CommandName == "VerFactura")
            {
                Response.Redirect("Facturas.aspx?id=" + idVenta);
            }
            else if(e.CommandName == "AnularVenta")
            {
                try
                {
                    VentaNegocio negocio = new VentaNegocio();
                    bool anulado = negocio.anularVenta(idVenta);

                    if (anulado)
                    {
                        gvVentas.DataSource = negocio.listar();
                        gvVentas.DataBind();
                    }
                    else
                    {
                        lblError.Text = "No se puede anular la venta";
                    }
                }
                catch (Exception ex)
                {
                    Session.Add("error", ex.ToString());
                }
            }
        }

    }
}