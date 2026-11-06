using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dominio;
using Negocio;
namespace TPI_FINAL_GRUPO8
{
    public partial class FormMarca : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string id = Request.QueryString["id"];
                int idMarca;

                if (int.TryParse(id, out idMarca))
                {
                    MarcaNegocio negocio = new MarcaNegocio();
                    Marca seleccionada = negocio.BuscarPorId(idMarca);

                    if (seleccionada != null)
                    {
                        tituloMarca.InnerText = "Editar marca";
                        txtNombre.Text = seleccionada.Nombre;

                        btnDesactivar.Visible = seleccionada.Activo;
                        btnReactivar.Visible = !seleccionada.Activo;
                    }
                }
            }
        }
        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            Page.Validate("Marca");

            if (!Page.IsValid)
            {
                return;
            }

            try
            {
                Marca nueva = new Marca();
                nueva.Nombre = txtNombre.Text.Trim();

                MarcaNegocio negocio = new MarcaNegocio();
                string id = Request.QueryString["id"];

                if (id == null)
                {
                    negocio.Agregar(nueva);
                }
                else
                {
                    int idMarca;

                    if (!int.TryParse(id, out idMarca) || idMarca <= 0)
                    {
                        throw new Exception("El ID de la marca no es válido.");
                    }

                    nueva.IdMarca = idMarca;
                    negocio.Modificar(nueva);
                }

                Response.Redirect("Marcas.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
            }
            catch (Exception)
            {
                throw;
            }
        }

        protected void btnDesactivar_Click(object sender, EventArgs e)
        {
            pnlConfirmarDesactivacion.Visible = true;
            btnDesactivar.Visible = false;
            accionesGuardar.Visible = false;
        }

        protected void btnCancelarDesactivacion_Click(object sender, EventArgs e)
        {
            pnlConfirmarDesactivacion.Visible = false;
            btnDesactivar.Visible = true;
        }

        protected void btnConfirmarDesactivacion_Click(object sender, EventArgs e)
        {
            int idMarca;

            if (!int.TryParse(Request.QueryString["id"], out idMarca) || idMarca <= 0)
            {
                throw new Exception("El ID de la marca no es válido.");
            }

            MarcaNegocio negocio = new MarcaNegocio();
            negocio.Desactivar(idMarca);

            Response.Redirect("Marcas.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }

        protected void btnReactivar_Click(object sender, EventArgs e)
        {
            int idMarca;

            if (!int.TryParse(Request.QueryString["id"], out idMarca) || idMarca <= 0)
            {
                throw new Exception("El ID de la marca no es válido.");
            }

            MarcaNegocio negocio = new MarcaNegocio();
            negocio.Reactivar(idMarca);

            Response.Redirect("Marcas.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }
    }
}