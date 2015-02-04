using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sentosa.Modules.ContactUs.Models
{
    public class ContactUs
    {
        public int Id { get; set; }
        public string Salutation { get; set; }
        public string EmailAddress { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string ContactNo { get; set; }
        public string Country { get; set; }
        public string Feedback { get; set; }
        public string Category { get; set; }
        public bool MailSent { get; set; }
        public string SmtpError { get; set; }
        public DateTime CreatedDateTime { get; set; }
        public string SalesForceId { get; set; }
    }
}