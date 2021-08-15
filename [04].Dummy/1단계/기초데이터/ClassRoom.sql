/********************************
-- 강의실 더미데이터 6개
**********************************/
create sequence classRoomSeq;
--drop sequence classRoomSeq;
select * from tblClassRoom;
--delete from tblClassRoom;

INSERT INTO tblClassRoom (seq, name, max, wifiName, wifiPW, os, exist) VALUES(classRoomSeq.nextval, '강의실1', 30, 'SK_WIFIGIGA335_5G', '7556315', 'Windows', default);
INSERT INTO tblClassRoom (seq, name, max, wifiName, wifiPW, os, exist) VALUES(classRoomSeq.nextval, '강의실2', 30, 'KT_GIGA_5G_95DA', '5342623', 'Windows', default);
INSERT INTO tblClassRoom (seq, name, max, wifiName, wifiPW, os, exist) VALUES(classRoomSeq.nextval, '강의실3', 30, 'IPTIME_4313.5B', '8401423', 'Mac', default);
INSERT INTO tblClassRoom (seq, name, max, wifiName, wifiPW, os, exist) VALUES(classRoomSeq.nextval, '강의실4', 26, 'KT_GIGA_5G_Wave2_2B34', '8394665', 'Mac', default);
INSERT INTO tblClassRoom (seq, name, max, wifiName, wifiPW, os, exist) VALUES(classRoomSeq.nextval, '강의실5', 26, 'U+_Net_998F', '2258609', 'Linux', default);
INSERT INTO tblClassRoom (seq, name, max, wifiName, wifiPW, os, exist) VALUES(classRoomSeq.nextval, '강의실6', 26, 'Olleh_Wifi_6AXE', '5115678', 'Linux', default);

commit;