using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using DotNetNuke.Common.Utilities;
using DotNetNuke.Data;

namespace Sentosa.Modules.Tag.Models
{
    public class TagController
    {
        public IList<Tag> GetTag(int Id)
        {
            return CBO.FillCollection<Tag>(DataProvider.Instance().ExecuteReader("GetTag")).Where(x => x.Id == Id).ToList();
        }

        public IList<Tag> GetTags(int TypeId, int LangId)
        {
            return CBO.FillCollection<Tag>(DataProvider.Instance().ExecuteReader("GetTag")).Where(x => x.TypeId == TypeId && x.LanguageId == LangId).OrderBy(y => y.Tagname).ToList();
        }

        public IList<TypePage> GetTypePages()
        {
            return CBO.FillCollection<TypePage>(DataProvider.Instance().ExecuteReader("GetTypePage")).ToList();
        }

        public IList<Language> GetLanguage()
        {
            return CBO.FillCollection<Language>(DataProvider.Instance().ExecuteReader("GetLanguage"));
        }

        public void AddTag(Tag tag)
        {
            tag.Id = DataProvider.Instance().ExecuteScalar<int>("AddTag",
                                                    tag.CommonId,
                                                    tag.LanguageId,
                                                    tag.TypeId,
                                                    tag.Tagname
                                                     );
        }

        public void UpdateTag(Tag tag)
        {
            tag.Id = DataProvider.Instance().ExecuteScalar<int>("UpdateTag",
                                                    tag.CommonId,
                                                    tag.LanguageId,
                                                    tag.TypeId,
                                                    tag.Tagname
                                                     );
        }

        public void DeleteTag(Tag tag)
        {
            DataProvider.Instance().ExecuteNonQuery("DeleteTag", tag.Id);
        }
    }
}