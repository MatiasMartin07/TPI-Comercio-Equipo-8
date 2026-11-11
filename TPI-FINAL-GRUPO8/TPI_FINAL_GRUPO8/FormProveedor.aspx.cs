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
        public bool confirmar
        {
            get
            {
                return ViewState["confirmar"] != null && (bool)ViewState["confirmar"];
            }
            set
            {
                ViewState["confirmar"] = value;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            txtId.Enabled = false;

            if (!IsPostBack)
            {
                confirmar = false;
                btnInactivar.Visible = false;

                string id = Request.QueryString["id"] != null ? Request.QueryString["id"].ToString() : "";

                if (!string.IsNullOrEmpty(id))
                {
                    int idNumerico;
                    try
                    {
                        idNumerico = int.Parse(id);
                    }
                    catch (FormatException)
                    {
                        lblIdError.Text = "El ID del proveedor no es válido.";
                        return;
                    }
                    catch (OverflowException)
                    {
                        lblIdError.Text = "El ID del proveedor no es válido.";
                        return;
                    }

                    ProveedoresNegocio pnegocio = new ProveedoresNegocio();
                    Dominio.Proveedores seleccionado = pnegocio.listarIdProveedor(idNumerico.ToString());

                    if (seleccionado.Id == 0)
                    {
                        lblIdError.Text = "No se encontró ese proveedor.";
                        return;
                    }

                    txtId.Text = idNumerico.ToString();
                    txtCodigo.Text = seleccionado.Codigo;
                    txtRazonSocial.Text = seleccionado.RazonSocial;
                    txtCuit.Text = seleccionado.Cuit;
                    txtTelefono.Text = seleccionado.Telefono;
                    txtEmail.Text = seleccionado.Mail;

                    btnInactivar.Visible = true;
                }
            }
        }
        protected void btnAceptar_Click(object sender, EventArgs e)
        {
            try
            {
                int idProveedorActual = 0;

                if (!string.IsNullOrEmpty(txtId.Text))
                {
                    idProveedorActual = int.Parse(txtId.Text);
                }

                string codigo = txtCodigo.Text.Trim();
                string razonSocial = txtRazonSocial.Text.Trim();
                string cuit = txtCuit.Text.Trim();
                string telefono = txtTelefono.Text.Trim();
                string email = txtEmail.Text.Trim();

                ProveedoresNegocio negocio = new ProveedoresNegocio();

                if (string.IsNullOrWhiteSpace(codigo))
                {
                    lblCodigoError.Text = "Debe ingresar un código.";
                    txtCodigo.BorderColor = System.Drawing.Color.Red;
                    return;
                }

                if (negocio.ExisteCod(codigo, idProveedorActual))
                {
                    lblCodigoError.Text = "El código ingresado ya existe.";
                    txtCodigo.BorderColor = System.Drawing.Color.Red;
                    return;
                }

                if (string.IsNullOrWhiteSpace(razonSocial))
                {
                    lblErrorRazonSocial.Text = "Debe ingresar una razón social.";
                    txtRazonSocial.BorderColor = System.Drawing.Color.Red;
                    return;
                }

                if (string.IsNullOrWhiteSpace(cuit))
                {
                    lblErrorCuit.Text = "Debe ingresar un CUIT.";
                    txtCuit.BorderColor = System.Drawing.Color.Red;
                    return;
                }

                bool cuitValido = cuit.Length == 11;

                for (int i = 0; i < cuit.Length; i++)
                {
                    if (cuit[i] < '0' || cuit[i] > '9')
                    {
                        cuitValido = false;
                        break;
                    }
                }
                
                if (!cuitValido)
                {
                    lblErrorCuit.Text = "El CUIT debe tener exactamente 11 dígitos, sin guiones.";
                    txtCuit.BorderColor = System.Drawing.Color.Red;
                    return;
                }

                if (negocio.ExisteCuit(cuit, idProveedorActual))
                {
                    lblErrorCuit.Text = "El CUIT ingresado ya existe.";
                    txtCuit.BorderColor = System.Drawing.Color.Red;
                    return;
                }

                if (string.IsNullOrWhiteSpace(email))
                {
                    lblEmailError.Text = "Debe ingresar un email.";
                    txtEmail.BorderColor = System.Drawing.Color.Red;
                    return;
                }

                if (string.IsNullOrWhiteSpace(telefono))
                {
                    lblErrorTelefono.Text = "Debe ingresar un teléfono.";
                    txtTelefono.BorderColor = System.Drawing.Color.Red;
                    return;
                }

                Dominio.Proveedores proveedor = new Dominio.Proveedores();
                proveedor.Id = idProveedorActual;
                proveedor.Codigo = codigo;
                proveedor.RazonSocial = razonSocial;
                proveedor.Cuit = cuit;
                proveedor.Telefono = telefono;
                proveedor.Mail = email;

                if (idProveedorActual == 0)
                {
                    negocio.agregarProveedor(proveedor);
                }
                else
                {
                    negocio.modificar(proveedor);
                }

                Response.Redirect("Proveedores.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
            }
            catch (Exception ex)
            {
                Session["error"] = ex.ToString();
                lblIdError.Text = "No se pudo guardar el proveedor. Revisá los datos e intentá nuevamente.";
            }
        }
        protected void btnInactivar_Click(object sender, EventArgs e)
        {
            confirmar = true;
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

        protected void txtTelefono_TextChanged(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(txtTelefono.Text))
            {
                lblErrorTelefono.Text = string.Empty;
                txtTelefono.BorderColor = System.Drawing.Color.Gray;
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
        protected void btnConfirma_Click(object sender, EventArgs e)
        {
            try
            {
                if (cbcConfirma.Checked)
                {
                    ProveedoresNegocio negocio = new ProveedoresNegocio();
                    negocio.eliminarLogico(int.Parse(txtId.Text));
                    Response.Redirect("Proveedores.aspx", false);
                }
            }
            catch (Exception ex)
            {
                Session.Add("error", ex.ToString());
            }
        }
    }
}
