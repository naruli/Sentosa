using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using DotNetNuke.Common.Utilities;
using DotNetNuke.Data;

namespace Sentosa.Modules.ContactUs.Models
{
    public class ContactUsController
    {
        public void AddContactUs(ContactUs contactUs)
        {
            contactUs.Id = DataProvider.Instance().ExecuteScalar<int>("AddContactUs",
                                                    contactUs.Salutation,
                                                    contactUs.EmailAddress,
                                                    contactUs.FirstName,
                                                    contactUs.LastName,
                                                    contactUs.ContactNo,
                                                    contactUs.Country,
                                                    contactUs.Feedback,
                                                    contactUs.Category
                                                     );
        }
    }
}