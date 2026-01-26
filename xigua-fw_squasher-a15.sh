git clone https://github.com/linux-msm/pil-squasher --depth 1
cd pil-squasher
make install

rm -rf /firmware-oneplus-a15/usr/lib/firmware/qcom/sm8550/aston

# adsp.mbn
/usr/local/bin/pil-squasher $1/firmware-oneplus-aston-a15/usr/lib/firmware/qcom/sm8550/xigua/adsp.mbn $1/firmware-oneplus-aston-a15/usr/lib/firmware/qcom/sm8550/xigua/adsp.mdt
rm -rf $1/firmware-oneplus-aston-a15/usr/lib/firmware/qcom/sm8550/xigua/adsp.mdt $1/firmware-oneplus-aston-a15/usr/lib/firmware/qcom/sm8550/xigua/adsp.b*

# adsp_dtb.mbn
/usr/local/bin/pil-squasher $1/firmware-oneplus-aston-a15/usr/lib/firmware/qcom/sm8550/xigua/adsp_dtb.mbn $1/firmware-oneplus-aston-a15/usr/lib/firmware/qcom/sm8550/xigua/adsp_dtb.mdt
rm -rf $1/firmware-oneplus-aston-a15/usr/lib/firmware/qcom/sm8550/xigua/adsp_dtb.mdt $1/firmware-oneplus-aston-a15/usr/lib/firmware/qcom/sm8550/xigua/adsp_dtb.b*

# cdsp.mbn
/usr/local/bin/pil-squasher $1/firmware-oneplus-aston-a15/usr/lib/firmware/qcom/sm8550/xigua/cdsp.mbn $1/firmware-oneplus-aston-a15/usr/lib/firmware/qcom/sm8550/xigua/cdsp.mdt
rm -rf $1/firmware-oneplus-aston-a15/usr/lib/firmware/qcom/sm8550/xigua/cdsp.mdt $1/firmware-oneplus-aston-a15/usr/lib/firmware/qcom/sm8550/xigua/cdsp.b*

# cdsp_dtb.mbn
/usr/local/bin/pil-squasher $1/firmware-oneplus-aston-a15/usr/lib/firmware/qcom/sm8550/xigua/cdsp_dtb.mbn $1/firmware-oneplus-aston-a15/usr/lib/firmware/qcom/sm8550/xigua/cdsp_dtb.mdt
rm -rf $1/firmware-oneplus-aston-a15/usr/lib/firmware/qcom/sm8550/xigua/cdsp_dtb.mdt $1/firmware-oneplus-aston-a15/usr/lib/firmware/qcom/sm8550/xigua/cdsp_dtb.b*

# ipa_fws.mbn
/usr/local/bin/pil-squasher $1/firmware-oneplus-aston-a15/usr/lib/firmware/qcom/sm8550/xigua/ipa_fws.mbn $1/firmware-oneplus-aston-a15/usr/lib/firmware/qcom/sm8550/xigua/ipa_fws.mdt
rm -rf $1/firmware-oneplus-aston-a15/usr/lib/firmware/qcom/sm8550/xigua/ipa_fws.mdt $1/firmware-oneplus-aston-a15/usr/lib/firmware/qcom/sm8550/xigua/ipa_fws.b*

# modem.mbn
/usr/local/bin/pil-squasher $1/firmware-oneplus-aston-a15/usr/lib/firmware/qcom/sm8550/xigua/modem.mbn $1/firmware-oneplus-aston-a15/usr/lib/firmware/qcom/sm8550/xigua/modem.mdt
rm -rf $1/firmware-oneplus-aston-a15/usr/lib/firmware/qcom/sm8550/xigua/modem.mdt $1/firmware-oneplus-aston-a15/usr/lib/firmware/qcom/sm8550/xigua/modem.b*

# modem_dtb.mbn
/usr/local/bin/pil-squasher $1/firmware-oneplus-aston-a15/usr/lib/firmware/qcom/sm8550/xigua/modem_dtb.mbn $1/firmware-oneplus-aston-a15/usr/lib/firmware/qcom/sm8550/xigua/modem_dtb.mdt
rm -rf $1/firmware-oneplus-aston-a15/usr/lib/firmware/qcom/sm8550/xigua/modem_dtb.mdt $1/firmware-oneplus-aston-a15/usr/lib/firmware/qcom/sm8550/xigua/modem_dtb.b*

cd $1
dpkg-deb --build --root-owner-group firmware-oneplus-a15
