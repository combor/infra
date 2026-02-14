moved {
  from = aws_route53_record.unifi
  to   = aws_route53_record.internal["unifi"]
}

moved {
  from = aws_route53_record.sonarr
  to   = aws_route53_record.internal["sonarr"]
}

moved {
  from = aws_route53_record.radarr
  to   = aws_route53_record.internal["radarr"]
}

moved {
  from = aws_route53_record.prowlarr
  to   = aws_route53_record.internal["prowlarr"]
}

moved {
  from = aws_route53_record.deluge
  to   = aws_route53_record.internal["deluge"]
}

moved {
  from = aws_route53_record.adguard
  to   = aws_route53_record.internal["adguard"]
}

moved {
  from = aws_route53_record.external
  to   = aws_route53_record.external["plex"]
}

moved {
  from = aws_route53_record.overseerr
  to   = aws_route53_record.external["overseerr"]
}

moved {
  from = aws_route53_record.photos
  to   = aws_route53_record.external["photos"]
}

moved {
  from = aws_route53_record.proton_dkim
  to   = aws_route53_record.proton_dkim["protonmail"]
}

moved {
  from = aws_route53_record.proton_dkim2
  to   = aws_route53_record.proton_dkim["protonmail2"]
}

moved {
  from = aws_route53_record.proton_dkim3
  to   = aws_route53_record.proton_dkim["protonmail3"]
}
