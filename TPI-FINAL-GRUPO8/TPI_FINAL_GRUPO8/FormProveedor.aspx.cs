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
    public partial class FormProveedor : System.Web.UI.Page
    {
        public bool confirmar { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            txtId.Enabled = false;
            confirmar = false;

            if (!IsPostBack)
            {
                string id = Request.QueryString["id"] != null ? Request.QueryString["id"].ToString() : "";
                if (id != "")
                {
                    ProveedoresNegocio neg = new ProveedoresNegocio();
                    Dominio.Proveedores seleccionado = neg.listarIdProveedor(id);
                    Session.Add("proveedorSeleccionado", seleccionado);

                    txtId.Text = id;
                    txtCodigo.Text = seleccionado.Codigo;
                    txtRazonSocial.Text = seleccionado.RazonSocial;
                    txtCuit.Text = seleccionado.Cuit;
                    txtTelefono.Text = seleccionado.Telefono;
                    txtEmail.Text = seleccionado.Mail;
                }
            }
        }
        protected void btnAceptar_Click(object sender, EventArgs e)
        {
            try
            {
                Proveedores proveedor = new Proveedores();
                ProveedoresNegocio negocio = new ProveedoresNegocio();
                string codigoIngresado = txtCodigo.Text.Trim();
                string cuitIngresado = txtCuit.Text.Trim();
                int idProveedorActual = string.IsNullOrEmpty(txtId.Text) ? 0 : int.Parse(txtId.Text);

                if (string.IsNullOrEmpty(txtCodigo.Text))
                {
                    lblCodigoError.Text = "Debe Ingresar un Codigo";
                    txtCodigo.BorderColor = System.Drawing.Color.Red;
                    return;
                }
                else if (negocio.ExisteCod(codigoIngresado, idProveedorActual))
                {
                    lblCodigoError.Text = "El Codigo ingresado ya existe";
                    txtCodigo.BorderColor = System.Drawing.Color.Red;
                    return;
                }
                else if (string.IsNullOrEmpty(txtRazonSocial.Text))
                {
                    lblErrorRazonSocial.Text = "Debe Ingresar una Razon Social";
                    txtRazonSocial.BorderColor = System.Drawing.Color.Red;
                    return;
                }
                else if (string.IsNullOrEmpty(txtCuit.Text))
                {
                    lblErrorCuit.Text = "Debe Ingresar un Cuit";
                    txtCuit.BorderColor = System.Drawing.Color.Red;
                    return;
                }
                else if (negocio.ExisteCuit(cuitIngresado, idProveedorActual))
                {
                    lblErrorCuit.Text = "El Cuit ingresado ya existe";
                    txtCuit.BorderColor = System.Drawing.Color.Red;
                    return;
                }
                else if (string.IsNullOrEmpty(txtEmail.Text))
                {
                    lblEmailError.Text = "Debe Ingresar un Email";
                    txtEmail.BorderColor = System.Drawing.Color.Red;
                    return;
                }
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
        protected void btnInactivar_Click(object sender, EventArgs e)
        {
            try
            {
                ProveedoresNegocio negocio = new ProveedoresNegocio();
                Dominio.Proveedores seleccionado = (Dominio.Proveedores)Session["proveedorSeleccionado"];

                negocio.eliminarLogico(seleccionado.Id, !seleccionado.Activo);
                Response.Redirect("Proveedores.aspx", false);

            }
            catch (Exception ex)
            {
                Session.Add("error", ex.ToString());
            }
        }
        protected void txtCodigo_TextChanged(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(txtCodigo.Text))
            {
                lblCodigoError.Text = string.Empty;
                txtCodigo.BorderColor = System.Drawing.Color.Gray;
            }
        }
        protected void txtRazonSocial_TextChanged(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(txtRazonSocial.Text))
            {
                lblErrorRazonSocial.Text = string.Empty;
                txtRazonSocial.BorderColor = System.Drawing.Color.Gray;
            }
        }
        protected void txtCuit_TextChanged(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(txtCuit.Text))
            {
                lblErrorCuit.Text = string.Empty;
                txtCuit.BorderColor = System.Drawing.Color.Gray;
            }
        }
        protected void txtEmail_TextChanged(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(txtEmail.Text))
            {
                lblEmailError.Text = string.Empty;
                txtEmail.BorderColor = System.Drawing.Color.Gray;
            }
        }
    }
}
