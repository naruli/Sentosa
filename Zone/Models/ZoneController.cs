using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using DotNetNuke.Common.Utilities;
using DotNetNuke.Data;

namespace Sentosa.Modules.Zone.Models
{
    public class ZoneController
    {
        public IList<Zone> GetZones()
        {
            return CBO.FillCollection<Zone>(DataProvider.Instance().ExecuteReader("GetZone")).ToList();
        }

        public IList<Zone> GetZone(int Id)
        {
            return CBO.FillCollection<Zone>(DataProvider.Instance().ExecuteReader("GetZone")).Where(x => x.Id == Id).ToList();
        }

        public void AddZone(Zone zone)
        {
            zone.Id = DataProvider.Instance().ExecuteScalar<int>("AddZone",
                                                    zone.ZoneName
                                                     );
        }

        public void UpdateZone(Zone zone)
        {
            zone.Id = DataProvider.Instance().ExecuteScalar<int>("UpdateZone",
                                                    zone.Id,
                                                    zone.ZoneName
                                                     );
        }

        public void DeleteZone(Zone zone)
        {
            DataProvider.Instance().ExecuteNonQuery("DeleteZone", zone.Id);
        }
    }
}