﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="Sentosa.Modules.ContactUs.View" %>
<%@ Register TagName="label" TagPrefix="dnn" Src="~/controls/labelcontrol.ascx" %>

<section id="page-title">
    <div class="container">
        <div class="row">
            <div class="col-xs-10">
                <h1>Contact Us</h1>
                <p>Your say matters! Let us know how we're doing.</p>
            </div><!--/ .col-xs-12 -->
        </div><!--/ .row -->
    </div><!--/ .container -->
</section><!--/ #page-title -->
<nav class="sub-nav">
    <div class="container">
        <div class="row">
            <div class="col-xs-12">
                <ul>
                    <%--<li class="active"><a href="#">Overview</a></li>
                    <li><a href="#">Tickets</a></li>
                    <li><a href="#">Visitor Informations</a></li>--%>
                </ul>
            </div><!--/ .col-xs-12 -->
        </div><!--/ .row -->
    </div><!--/ .container -->
</nav><!--/ .sub-nav -->
<section class="page-article">
    <div class="container">
        <div class="row">
            <article class="col-xs-12 col-md-9">
                <p>
                    Our Guest Services Officers are available at 
                    <br>
                    <strong>1800-SENTOSA (736 8672) / +65-6736 8672 | Mon to Sun, from 9am to 6pm</strong>
                    <br>
                    Or you may reach us via email at 
                    <a href="mailto:guest_services@sentosa.com.sg">guest_services@sentosa.com.sg</a>
                </p>

                <h2>Sentosa Leisure Management Pte Ltd</h2>
                <p>
                    To send us your feedback, please mail it to
                    <br>
                    <strong>
                        Sentosa Leisure Management Pte Ltd
                        <br>
                        39 Artillery Avenue, Sentosa, Singapore 099958 
                    </strong>
                </p>
                <p>
                    To share any of your experiences with us, please complete the form below
                </p>
                <p>
                    Please fill in the following details
                </p>

                <form>
                    <div class="dnnFormItem">
                        <dnn:label ID="Label3" runat="server" Text="Salutation*" />
                        <asp:DropDownList ID="dropSalutation" runat="server">
                            <asp:ListItem Value="" Selected="True">Please Select One</asp:ListItem>
                            <asp:ListItem Value="Dr">Dr</asp:ListItem>
                            <asp:ListItem Value="Mr">Mr</asp:ListItem>
                            <asp:ListItem Value="Mrs">Mrs</asp:ListItem>
                            <asp:ListItem Value="Ms">Ms</asp:ListItem>
                            <asp:ListItem Value="Mdm">Mdm</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="dnnFormItem">
                        <dnn:label ID="Label8" runat="server" Text="First Name" />
                        <asp:TextBox ID="txtFirstName" runat="server" />
                    </div>
                    <div class="dnnFormItem">
                        <dnn:label ID="Label1" runat="server" Text="Last Name" />
                        <asp:TextBox ID="txtLastName" runat="server" />
                    </div>
                    <div class="dnnFormItem">
                        <dnn:label ID="Label2" runat="server" Text="Email Address" />
                        <asp:TextBox ID="txtAddress" runat="server" />
                    </div>
                    <div class="dnnFormItem">
                        <dnn:label ID="Label4" runat="server" Text="Contact No" />
                        <asp:TextBox ID="txtContactNo" runat="server" />
                    </div>
                    <div class="dnnFormItem">
                        <dnn:label ID="Label5" runat="server" Text="Country of Residence*" />
                        <asp:DropDownList ID="dropCountry" runat="server">
		                    <asp:ListItem Value="" Selected="True">Please Select One</asp:ListItem>
		                    <asp:ListItem Value="Afghanistan">Afghanistan</asp:ListItem>
		                    <asp:ListItem Value="Albania">Albania</asp:ListItem>
		                    <asp:ListItem Value="Andorra">Andorra</asp:ListItem>
		                    <asp:ListItem Value="Angola">Angola</asp:ListItem>
		                    <asp:ListItem Value="Anguilla">Anguilla</asp:ListItem>
		                    <asp:ListItem Value="Antigua and Barbuda">Antigua and Barbuda</asp:ListItem>
		                    <asp:ListItem Value="Argentina">Argentina</asp:ListItem>
		                    <asp:ListItem Value="Armenia">Armenia</asp:ListItem>
		                    <asp:ListItem Value="Aruba">Aruba</asp:ListItem>
		                    <asp:ListItem Value="Ascension">Ascension</asp:ListItem>
		                    <asp:ListItem Value="Australia">Australia</asp:ListItem>
		                    <asp:ListItem Value="Austria">Austria</asp:ListItem>
		                    <asp:ListItem Value="Azerbaijan">Azerbaijan</asp:ListItem>
		                    <asp:ListItem Value="Azores">Azores</asp:ListItem>
		                    <asp:ListItem Value="Bahamas">Bahamas</asp:ListItem>
		                    <asp:ListItem Value="Bahrain">Bahrain</asp:ListItem>
		                    <asp:ListItem Value="Bangladesh">Bangladesh</asp:ListItem>
		                    <asp:ListItem Value="Barbados">Barbados</asp:ListItem>
		                    <asp:ListItem Value="Belarus">Belarus</asp:ListItem>
		                    <asp:ListItem Value="Belgium">Belgium</asp:ListItem>
		                    <asp:ListItem Value="Belize">Belize</asp:ListItem>
		                    <asp:ListItem Value="Benin">Benin</asp:ListItem>
		                    <asp:ListItem Value="Bermuda">Bermuda</asp:ListItem>
		                    <asp:ListItem Value="Bhutan">Bhutan</asp:ListItem>
		                    <asp:ListItem Value="Bolivia">Bolivia</asp:ListItem>
		                    <asp:ListItem Value="Bosnia and Herzegovina">Bosnia and Herzegovina</asp:ListItem>
		                    <asp:ListItem Value="Botswana">Botswana</asp:ListItem>
		                    <asp:ListItem Value="Brazil">Brazil</asp:ListItem>
		                    <asp:ListItem Value="Brunei Darussalam">Brunei Darussalam</asp:ListItem>
		                    <asp:ListItem Value="Bulgaria">Bulgaria</asp:ListItem>
		                    <asp:ListItem Value="Burkina Faso">Burkina Faso</asp:ListItem>
		                    <asp:ListItem Value="Burundi">Burundi</asp:ListItem>
		                    <asp:ListItem Value="Cambodia">Cambodia</asp:ListItem>
		                    <asp:ListItem Value="Cameroon">Cameroon</asp:ListItem>
		                    <asp:ListItem Value="Canada">Canada</asp:ListItem>
		                    <asp:ListItem Value="Canary Islands">Canary Islands</asp:ListItem>
		                    <asp:ListItem Value="Cape Verde">Cape Verde</asp:ListItem>
		                    <asp:ListItem Value="Cayman Islands">Cayman Islands</asp:ListItem>
		                    <asp:ListItem Value="Central African Republic">Central African Republic</asp:ListItem>
		                    <asp:ListItem Value="Chad">Chad</asp:ListItem>
		                    <asp:ListItem Value="Chagos Islands">Chagos Islands</asp:ListItem>
		                    <asp:ListItem Value="Chile">Chile</asp:ListItem>
		                    <asp:ListItem Value="China">China</asp:ListItem>
		                    <asp:ListItem Value="Christmas Island">Christmas Island</asp:ListItem>
		                    <asp:ListItem Value="Cocos Keeling Islands">Cocos Keeling Islands</asp:ListItem>
		                    <asp:ListItem Value="Colombia">Colombia</asp:ListItem>
		                    <asp:ListItem Value="Comoros">Comoros</asp:ListItem>
		                    <asp:ListItem Value="Cook Islands">Cook Islands</asp:ListItem>
		                    <asp:ListItem Value="Costa Rica">Costa Rica</asp:ListItem>
		                    <asp:ListItem Value="Cote d'Ivoire">Cote d'Ivoire</asp:ListItem>
		                    <asp:ListItem Value="Croatia">Croatia</asp:ListItem>
		                    <asp:ListItem Value="Crozet Archipelago">Crozet Archipelago</asp:ListItem>
		                    <asp:ListItem Value="Cuba">Cuba</asp:ListItem>
		                    <asp:ListItem Value="Cyprus">Cyprus</asp:ListItem>
		                    <asp:ListItem Value="Czech Republic">Czech Republic</asp:ListItem>
		                    <asp:ListItem Value="Denmark">Denmark</asp:ListItem>
		                    <asp:ListItem Value="Diego Garcia">Diego Garcia</asp:ListItem>
		                    <asp:ListItem Value="Djibouti">Djibouti</asp:ListItem>
		                    <asp:ListItem Value="Dominica">Dominica</asp:ListItem>
		                    <asp:ListItem Value="Dominican Republic">Dominican Republic</asp:ListItem>
		                    <asp:ListItem Value="East Timor">East Timor</asp:ListItem>
		                    <asp:ListItem Value="Easter Island">Easter Island</asp:ListItem>
		                    <asp:ListItem Value="Ecuador">Ecuador</asp:ListItem>
		                    <asp:ListItem Value="Egypt">Egypt</asp:ListItem>
		                    <asp:ListItem Value="El Salvador">El Salvador</asp:ListItem>
		                    <asp:ListItem Value="Equatorial Guinea">Equatorial Guinea</asp:ListItem>
		                    <asp:ListItem Value="Estonia">Estonia</asp:ListItem>
		                    <asp:ListItem Value="Ethiopia">Ethiopia</asp:ListItem>
		                    <asp:ListItem Value="Falkland Islands">Falkland Islands</asp:ListItem>
		                    <asp:ListItem Value="Faroe Islands">Faroe Islands</asp:ListItem>
		                    <asp:ListItem Value="Fiji">Fiji</asp:ListItem>
		                    <asp:ListItem Value="Finland">Finland</asp:ListItem>
		                    <asp:ListItem Value="France">France</asp:ListItem>
		                    <asp:ListItem Value="French Polynesia">French Polynesia</asp:ListItem>
		                    <asp:ListItem Value="Gabon">Gabon</asp:ListItem>
		                    <asp:ListItem Value="Gambia">Gambia</asp:ListItem>
		                    <asp:ListItem Value="Georgia">Georgia</asp:ListItem>
		                    <asp:ListItem Value="Germany">Germany</asp:ListItem>
		                    <asp:ListItem Value="Ghana">Ghana</asp:ListItem>
		                    <asp:ListItem Value="Gibraltar">Gibraltar</asp:ListItem>
		                    <asp:ListItem Value="Greece">Greece</asp:ListItem>
		                    <asp:ListItem Value="Greenland">Greenland</asp:ListItem>
		                    <asp:ListItem Value="Grenada">Grenada</asp:ListItem>
		                    <asp:ListItem Value="Guadeloupe">Guadeloupe</asp:ListItem>
		                    <asp:ListItem Value="Guam">Guam</asp:ListItem>
		                    <asp:ListItem Value="Guatemala">Guatemala</asp:ListItem>
		                    <asp:ListItem Value="Guiana">Guiana</asp:ListItem>
		                    <asp:ListItem Value="Guinea">Guinea</asp:ListItem>
		                    <asp:ListItem Value="Guinea-Bissau">Guinea-Bissau</asp:ListItem>
		                    <asp:ListItem Value="Guyana">Guyana</asp:ListItem>
		                    <asp:ListItem Value="Haiti">Haiti</asp:ListItem>
		                    <asp:ListItem Value="Hawaii">Hawaii</asp:ListItem>
		                    <asp:ListItem Value="Honduras">Honduras</asp:ListItem>
		                    <asp:ListItem Value="Hong Kong">Hong Kong</asp:ListItem>
		                    <asp:ListItem Value="Howland Island">Howland Island</asp:ListItem>
		                    <asp:ListItem Value="Hungary">Hungary</asp:ListItem>
		                    <asp:ListItem Value="ICAO">ICAO</asp:ListItem>
		                    <asp:ListItem Value="Iceland">Iceland</asp:ListItem>
		                    <asp:ListItem Value="India">India</asp:ListItem>
		                    <asp:ListItem Value="Indonesia">Indonesia</asp:ListItem>
		                    <asp:ListItem Value="Iran">Iran</asp:ListItem>
		                    <asp:ListItem Value="Iraq">Iraq</asp:ListItem>
		                    <asp:ListItem Value="Ireland">Ireland</asp:ListItem>
		                    <asp:ListItem Value="Israel">Israel</asp:ListItem>
		                    <asp:ListItem Value="Italy">Italy</asp:ListItem>
		                    <asp:ListItem Value="Jamaica">Jamaica</asp:ListItem>
		                    <asp:ListItem Value="Japan">Japan</asp:ListItem>
		                    <asp:ListItem Value="Jarvis Island">Jarvis Island</asp:ListItem>
		                    <asp:ListItem Value="Johnston Island">Johnston Island</asp:ListItem>
		                    <asp:ListItem Value="Jordan">Jordan</asp:ListItem>
		                    <asp:ListItem Value="Kazakhstan">Kazakhstan</asp:ListItem>
		                    <asp:ListItem Value="Kenya">Kenya</asp:ListItem>
		                    <asp:ListItem Value="Kerguelen">Kerguelen</asp:ListItem>
		                    <asp:ListItem Value="Kiribati">Kiribati</asp:ListItem>
		                    <asp:ListItem Value="Korea">Korea</asp:ListItem>
		                    <asp:ListItem Value="Kuwait">Kuwait</asp:ListItem>
		                    <asp:ListItem Value="Kyrgyzstan">Kyrgyzstan</asp:ListItem>
		                    <asp:ListItem Value="Laos">Laos</asp:ListItem>
		                    <asp:ListItem Value="Latvia">Latvia</asp:ListItem>
		                    <asp:ListItem Value="Lebanon">Lebanon</asp:ListItem>
		                    <asp:ListItem Value="Lesotho">Lesotho</asp:ListItem>
		                    <asp:ListItem Value="Liberia">Liberia</asp:ListItem>
		                    <asp:ListItem Value="Libya">Libya</asp:ListItem>
		                    <asp:ListItem Value="Liechtenstein">Liechtenstein</asp:ListItem>
		                    <asp:ListItem Value="Lithuania">Lithuania</asp:ListItem>
		                    <asp:ListItem Value="Luxembourg">Luxembourg</asp:ListItem>
		                    <asp:ListItem Value="Macau">Macau</asp:ListItem>
		                    <asp:ListItem Value="Madagascar">Madagascar</asp:ListItem>
		                    <asp:ListItem Value="Madeira">Madeira</asp:ListItem>
		                    <asp:ListItem Value="Malawi">Malawi</asp:ListItem>
		                    <asp:ListItem Value="Malaysia">Malaysia</asp:ListItem>
		                    <asp:ListItem Value="Maldives">Maldives</asp:ListItem>
		                    <asp:ListItem Value="Mali">Mali</asp:ListItem>
		                    <asp:ListItem Value="Malta">Malta</asp:ListItem>
		                    <asp:ListItem Value="Marion Island">Marion Island</asp:ListItem>
		                    <asp:ListItem Value="Marshall Islands">Marshall Islands</asp:ListItem>
		                    <asp:ListItem Value="Martinique">Martinique</asp:ListItem>
		                    <asp:ListItem Value="Mauritania">Mauritania</asp:ListItem>
		                    <asp:ListItem Value="Mauritius">Mauritius</asp:ListItem>
		                    <asp:ListItem Value="Mayotte">Mayotte</asp:ListItem>
		                    <asp:ListItem Value="Mexico">Mexico</asp:ListItem>
		                    <asp:ListItem Value="Micronesia">Micronesia</asp:ListItem>
		                    <asp:ListItem Value="Midway Islands">Midway Islands</asp:ListItem>
		                    <asp:ListItem Value="Moldova">Moldova</asp:ListItem>
		                    <asp:ListItem Value="Monaco">Monaco</asp:ListItem>
		                    <asp:ListItem Value="Mongolia">Mongolia</asp:ListItem>
		                    <asp:ListItem Value="Montserrat">Montserrat</asp:ListItem>
		                    <asp:ListItem Value="Morocco">Morocco</asp:ListItem>
		                    <asp:ListItem Value="Mozambique">Mozambique</asp:ListItem>
		                    <asp:ListItem Value="Myanmar">Myanmar</asp:ListItem>
		                    <asp:ListItem Value="Namibia">Namibia</asp:ListItem>
		                    <asp:ListItem Value="Nauru">Nauru</asp:ListItem>
		                    <asp:ListItem Value="Nepal">Nepal</asp:ListItem>
		                    <asp:ListItem Value="Netherlands">Netherlands</asp:ListItem>
		                    <asp:ListItem Value="Netherlands Antilles">Netherlands Antilles</asp:ListItem>
		                    <asp:ListItem Value="New Caledonia">New Caledonia</asp:ListItem>
		                    <asp:ListItem Value="New Zealand">New Zealand</asp:ListItem>
		                    <asp:ListItem Value="Nicaragua">Nicaragua</asp:ListItem>
		                    <asp:ListItem Value="Niger">Niger</asp:ListItem>
		                    <asp:ListItem Value="Nigeria">Nigeria</asp:ListItem>
		                    <asp:ListItem Value="Niue">Niue</asp:ListItem>
		                    <asp:ListItem Value="Norfolk Island">Norfolk Island</asp:ListItem>
		                    <asp:ListItem Value="Northern Marianas">Northern Marianas</asp:ListItem>
		                    <asp:ListItem Value="Norway">Norway</asp:ListItem>
		                    <asp:ListItem Value="Oman">Oman</asp:ListItem>
		                    <asp:ListItem Value="Pakistan">Pakistan</asp:ListItem>
		                    <asp:ListItem Value="Palau">Palau</asp:ListItem>
		                    <asp:ListItem Value="Palmyra Island">Palmyra Island</asp:ListItem>
		                    <asp:ListItem Value="Panama">Panama</asp:ListItem>
		                    <asp:ListItem Value="Papua New Guinea">Papua New Guinea</asp:ListItem>
		                    <asp:ListItem Value="Paraguay">Paraguay</asp:ListItem>
		                    <asp:ListItem Value="Peru">Peru</asp:ListItem>
		                    <asp:ListItem Value="Philippines">Philippines</asp:ListItem>
		                    <asp:ListItem Value="Phoenix Islands">Phoenix Islands</asp:ListItem>
		                    <asp:ListItem Value="Pitcairn">Pitcairn</asp:ListItem>
		                    <asp:ListItem Value="Poland">Poland</asp:ListItem>
		                    <asp:ListItem Value="Portugal">Portugal</asp:ListItem>
		                    <asp:ListItem Value="Puerto Rico">Puerto Rico</asp:ListItem>
		                    <asp:ListItem Value="Qatar">Qatar</asp:ListItem>
		                    <asp:ListItem Value="Reunion">Reunion</asp:ListItem>
		                    <asp:ListItem Value="Rodrigues">Rodrigues</asp:ListItem>
		                    <asp:ListItem Value="Romania">Romania</asp:ListItem>
		                    <asp:ListItem Value="Russia">Russia</asp:ListItem>
		                    <asp:ListItem Value="Rwanda">Rwanda</asp:ListItem>
		                    <asp:ListItem Value="Saint Helena">Saint Helena</asp:ListItem>
		                    <asp:ListItem Value="Saint Kitts and Nevis">Saint Kitts and Nevis</asp:ListItem>
		                    <asp:ListItem Value="Saint Lucia">Saint Lucia</asp:ListItem>
		                    <asp:ListItem Value="Saint Paul and Amsterdam">Saint Paul and Amsterdam</asp:ListItem>
		                    <asp:ListItem Value="Saint Pierre and Miquelon">Saint Pierre and Miquelon</asp:ListItem>
		                    <asp:ListItem Value="Samoa (America)">Samoa (America)</asp:ListItem>
		                    <asp:ListItem Value="Samoa (Western)">Samoa (Western)</asp:ListItem>
		                    <asp:ListItem Value="San Marino">San Marino</asp:ListItem>
		                    <asp:ListItem Value="Sao Tome and Principe">Sao Tome and Principe</asp:ListItem>
		                    <asp:ListItem Value="Saudi Arabia">Saudi Arabia</asp:ListItem>
		                    <asp:ListItem Value="Senegal">Senegal</asp:ListItem>
		                    <asp:ListItem Value="Seychelles">Seychelles</asp:ListItem>
		                    <asp:ListItem Value="Sierra Leone">Sierra Leone</asp:ListItem>
		                    <asp:ListItem Value="Singapore">Singapore</asp:ListItem>
		                    <asp:ListItem Value="Slovakia">Slovakia</asp:ListItem>
		                    <asp:ListItem Value="Slovenia">Slovenia</asp:ListItem>
		                    <asp:ListItem Value="Solomon">Solomon</asp:ListItem>
		                    <asp:ListItem Value="Somalia">Somalia</asp:ListItem>
		                    <asp:ListItem Value="South Africa">South Africa</asp:ListItem>
		                    <asp:ListItem Value="Spain">Spain</asp:ListItem>
		                    <asp:ListItem Value="Sri Lanka">Sri Lanka</asp:ListItem>
		                    <asp:ListItem Value="Sudan">Sudan</asp:ListItem>
		                    <asp:ListItem Value="Surinam">Surinam</asp:ListItem>
		                    <asp:ListItem Value="Swan Islands">Swan Islands</asp:ListItem>
		                    <asp:ListItem Value="Swaziland">Swaziland</asp:ListItem>
		                    <asp:ListItem Value="Sweden">Sweden</asp:ListItem>
		                    <asp:ListItem Value="Switzerland">Switzerland</asp:ListItem>
		                    <asp:ListItem Value="Syria">Syria</asp:ListItem>
		                    <asp:ListItem Value="Taiwan">Taiwan</asp:ListItem>
		                    <asp:ListItem Value="Tajikistan">Tajikistan</asp:ListItem>
		                    <asp:ListItem Value="Tanzania">Tanzania</asp:ListItem>
		                    <asp:ListItem Value="Thailand">Thailand</asp:ListItem>
		                    <asp:ListItem Value="Togo">Togo</asp:ListItem>
		                    <asp:ListItem Value="Tokelau">Tokelau</asp:ListItem>
		                    <asp:ListItem Value="Tonga">Tonga</asp:ListItem>
		                    <asp:ListItem Value="Trinidad and Tobago">Trinidad and Tobago</asp:ListItem>
		                    <asp:ListItem Value="Tristan da cunha">Tristan da cunha</asp:ListItem>
		                    <asp:ListItem Value="Tunisia">Tunisia</asp:ListItem>
		                    <asp:ListItem Value="Turkey">Turkey</asp:ListItem>
		                    <asp:ListItem Value="Turkmenistan">Turkmenistan</asp:ListItem>
		                    <asp:ListItem Value="Turks and Caicos Islands">Turks and Caicos Islands</asp:ListItem>
		                    <asp:ListItem Value="Tuvalu">Tuvalu</asp:ListItem>
		                    <asp:ListItem Value="Uganda">Uganda</asp:ListItem>
		                    <asp:ListItem Value="Ukraine">Ukraine</asp:ListItem>
		                    <asp:ListItem Value="United Arab Emirates">United Arab Emirates</asp:ListItem>
		                    <asp:ListItem Value="United Kingdom">United Kingdom</asp:ListItem>
		                    <asp:ListItem Value="United States of America">United States of America</asp:ListItem>
		                    <asp:ListItem Value="Uruguay">Uruguay</asp:ListItem>
		                    <asp:ListItem Value="Uzbekistan">Uzbekistan</asp:ListItem>
		                    <asp:ListItem Value="Vanuatu">Vanuatu</asp:ListItem>
		                    <asp:ListItem Value="Vatican">Vatican</asp:ListItem>
		                    <asp:ListItem Value="Venezuela">Venezuela</asp:ListItem>
		                    <asp:ListItem Value="Vietnam">Vietnam</asp:ListItem>
		                    <asp:ListItem Value="Virgin Islands (British)">Virgin Islands (British)</asp:ListItem>
		                    <asp:ListItem Value="Virgin Islands (US)">Virgin Islands (US)</asp:ListItem>
		                    <asp:ListItem Value="Wake Island">Wake Island</asp:ListItem>
		                    <asp:ListItem Value="Wallis and Futuna">Wallis and Futuna</asp:ListItem>
		                    <asp:ListItem Value="Western Sahara">Western Sahara</asp:ListItem>
		                    <asp:ListItem Value="Yemen">Yemen</asp:ListItem>
		                    <asp:ListItem Value="Yugoslavia">Yugoslavia</asp:ListItem>
		                    <asp:ListItem Value="Zaire">Zaire</asp:ListItem>
		                    <asp:ListItem Value="Zambia">Zambia</asp:ListItem>
		                    <asp:ListItem Value="Zanzibar">Zanzibar</asp:ListItem>
		                    <asp:ListItem Value="Zimbabwe">Zimbabwe</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="dnnFormItem">
                        <dnn:label ID="Label6" runat="server" Text="Category*" />
                        <asp:DropDownList ID="dropCategory" runat="server">
		                    <asp:ListItem Value="" Selected="True">Please Select One</asp:ListItem>
		                    <asp:ListItem Value="General Enquiries/Comments">General Enquiries/Comments</asp:ListItem>
		                    <asp:ListItem Value="Business Opportunities">Business Opportunities</asp:ListItem>
		                    <asp:ListItem Value="Islander">Islander</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="dnnFormItem">
                        <dnn:label ID="Label7" runat="server" Text="Feedback*" />
                        <asp:TextBox ID="txtFeedback" TextMode="MultiLine" runat="server" />
                    </div>
                    <p>
                        <span>
                            <asp:CheckBox ID="chkAgreement" runat="server" />
                        </span>
                        <span id="txtAgreement" runat="server">
                            By submitting this form I consent to the collection, use and disclosure of my personal data for the purposes of processing the enquiry / feedback contained in this form and resolving any issues relating thereto. I also confirm that all information provided of myself are true and complete and understand that the information may be shared with SLM’s affiliates or related corporations for internal reporting purposes. Where I have provided personal data of individuals other than myself, I warrant that I am validly acting on behalf of each of these individuals, and have obtained their individual consents, to disclose their personal data to Sentosa Leisure Management Pte Ltd (“SLM”) and for SLM to collect, use, disclose and process their personal data for the abovestated purpose. I understand that SLM may contact me via my email or telephone number(s) provided in this form to follow-up on the enquiry / feedback and that such telephone conversations may be recorded for quality coaching and record-keeping purposes.
                        </span>
                    </p>
                    <asp:Button ID="btnSubmit" CssClass="dnnPrimaryAction" OnClick="btnSubmit_Click" Text="Submit" runat="server" />
                </form>
            </article>
        </div><!--/ .row -->
    </div><!--/ .container -->
</section><!--/ #page-article -->