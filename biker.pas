uses CRT;
label save_menu, save_newgame, save_loading, adventure, repair, bike_shop, shop_read, trucks, truck_school, race, save_p0, save_p1, save_p2, save_p3, save_p4, save_p5, save_p6, save_p7, save_p8, save_p9, save_p10, save_p11, save_p12, save_p13, save_p14, save_p15, save_p16, save_p17, save_p18, save_p19, save_p20;
const
  key = 'ADMIN';
  damages = 40;
  towns = 20;
  delayer = 25;

procedure writedelay(s: string; n: integer);
begin
  if length(s) > 0 then begin
    for var i := 1 to length(s) do 
    begin
      write(Copy(s, i, 1));
      delay(n);
    end;
  end;
end;

procedure writespace(n: integer);
begin
  if n > 1 then begin
    for var i := 1 to n do write(' ');
  end;
end;

procedure writerub(n: integer);
begin
  var x: integer;
  x := n mod 10;
  case x of
    0, 5..9: write('рублей');
    1: write('рубль');
    2..4: write('рубля');
  end;
end;

var
  bike_df: text;  bike_damage_flag: array[1..damages] of boolean;
  bike_dn: text;  bike_damage_name: array[1..damages] of string;
  bike_dp: text;  bike_damage_price: array[1..damages] of integer;
  bike_dc: text;  bike_damage_comment: array[1..damages] of string;
  save_key: text;key_enable: boolean;key_try: byte;key_id: boolean;key_master: string;
  menu_off: boolean;menu_id: string;menu_id_int: integer;
  save_game: text; savegame: boolean;
  setup_off: boolean; setup_id: string;setup_id_int: integer;
  key_enable_check: string;setup_key_en: boolean;
  towname: text;town_name: array[0..towns] of string;
  town_road: array[0..towns, 0..towns] of byte;current_town: byte;town_roads: text;
  money: longword;repair_price: longword;
  point_off: boolean;
  tour: array[0..towns] of boolean;
  max_spd, avg_spd: byte;
  point_str: string; point_int: integer;
  adv_str: string; adv_int: integer;
  adv_off: boolean;
  summ: integer;randomer: integer;
  randomer1: integer;
  truck_master: real;
  truck_price: longword;
  bike_name: string;
  save_money, save_point, save_tour, save_truck_master, save_bikename, save_truckprice, save_bikespd: text;
  repairs: byte;
  repair_off: boolean; repair_str: string; repair_int: integer;
  names_bike: array[1..57] of string; bike_names: text;
  shop_off: boolean; shop_name, shop_str: string; shop_avg_spd, shop_max_spd, shop_price, shop_int: integer;
  shop_master: integer; save_shop_master: text;
  truck_count: byte;
  setx, sety: integer;
  truck_money: integer;
  school_off: boolean; school_str: string; school_int: integer;
  race_max1, race_max2, race_max3, race_max4, race_avg1, race_avg2, race_avg3, race_avg4: integer;
  prop1, prop2, prop3, prop4, prop5: integer;
  race_money: integer;
  race_off: boolean;

begin
  SetWindowTitle('Biker 1.0');
  begin
    assign(bike_dn, 'bin/bike_damage_names.dat');
    reset(bike_dn);for var i := 1 to damages do readln(bike_dn, bike_damage_name[i]);close(bike_dn);
    assign(bike_dp, 'bin/bike_damage_prices.dat');
    reset(bike_dp);for var i := 1 to damages do readln(bike_dp, bike_damage_price[i]);close(bike_dp);
    assign(bike_dc, 'bin/bike_damage_comments.dat');
    reset(bike_dc);for var i := 1 to damages do readln(bike_dc, bike_damage_comment[i]);close(bike_dc);
    assign(bike_names, 'bin/bikenames.dat');
    reset(bike_names);for var i := 1 to 57 do readln(bike_names, names_bike[i]);close(bike_names);
    assign(towname, 'bin/town_names.dat');
    reset(towname);for var i := 0 to towns do readln(towname, town_name[i]);close(towname);
    assign(town_roads, 'bin/town_road0.dat');
    reset(town_roads);for var i := 0 to towns do readln(town_roads, town_road[0, i]);close(town_roads);
    assign(town_roads, 'bin/town_road1.dat');
    reset(town_roads);for var i := 0 to towns do readln(town_roads, town_road[1, i]);close(town_roads);
    assign(town_roads, 'bin/town_road2.dat');
    reset(town_roads);for var i := 0 to towns do readln(town_roads, town_road[2, i]);close(town_roads);
    assign(town_roads, 'bin/town_road3.dat');
    reset(town_roads);for var i := 0 to towns do readln(town_roads, town_road[3, i]);close(town_roads);
    assign(town_roads, 'bin/town_road4.dat');
    reset(town_roads);for var i := 0 to towns do readln(town_roads, town_road[4, i]);close(town_roads);
    assign(town_roads, 'bin/town_road5.dat');
    reset(town_roads);for var i := 0 to towns do readln(town_roads, town_road[5, i]);close(town_roads);
    assign(town_roads, 'bin/town_road6.dat');
    reset(town_roads);for var i := 0 to towns do readln(town_roads, town_road[6, i]);close(town_roads);
    assign(town_roads, 'bin/town_road7.dat');
    reset(town_roads);for var i := 0 to towns do readln(town_roads, town_road[7, i]);close(town_roads);
    assign(town_roads, 'bin/town_road8.dat');
    reset(town_roads);for var i := 0 to towns do readln(town_roads, town_road[8, i]);close(town_roads);
    assign(town_roads, 'bin/town_road9.dat');
    reset(town_roads);for var i := 0 to towns do readln(town_roads, town_road[9, i]);close(town_roads);
    assign(town_roads, 'bin/town_road10.dat');
    reset(town_roads);for var i := 0 to towns do readln(town_roads, town_road[10, i]);close(town_roads);
    assign(town_roads, 'bin/town_road11.dat');
    reset(town_roads);for var i := 0 to towns do readln(town_roads, town_road[11, i]);close(town_roads);
    assign(town_roads, 'bin/town_road12.dat');
    reset(town_roads);for var i := 0 to towns do readln(town_roads, town_road[12, i]);close(town_roads);
    assign(town_roads, 'bin/town_road13.dat');
    reset(town_roads);for var i := 0 to towns do readln(town_roads, town_road[13, i]);close(town_roads);
    assign(town_roads, 'bin/town_road14.dat');
    reset(town_roads);for var i := 0 to towns do readln(town_roads, town_road[14, i]);close(town_roads);
    assign(town_roads, 'bin/town_road15.dat');
    reset(town_roads);for var i := 0 to towns do readln(town_roads, town_road[15, i]);close(town_roads);
    assign(town_roads, 'bin/town_road16.dat');
    reset(town_roads);for var i := 0 to towns do readln(town_roads, town_road[16, i]);close(town_roads);
    assign(town_roads, 'bin/town_road17.dat');
    reset(town_roads);for var i := 0 to towns do readln(town_roads, town_road[17, i]);close(town_roads);
    assign(town_roads, 'bin/town_road18.dat');
    reset(town_roads);for var i := 0 to towns do readln(town_roads, town_road[18, i]);close(town_roads);
    assign(town_roads, 'bin/town_road19.dat');
    reset(town_roads);for var i := 0 to towns do readln(town_roads, town_road[19, i]);close(town_roads);
    assign(town_roads, 'bin/town_road20.dat');
    reset(town_roads);for var i := 0 to towns do readln(town_roads, town_road[20, i]);close(town_roads);
    assign(save_key, 'save/save_keyenable.dat');
    reset(save_key);readln(save_key, key_enable);close(save_key);
    assign(save_game, 'save/save_game.dat');
    reset(save_game);readln(save_game, savegame);close(save_game);
    assign(save_money, 'save/save_money.dat');
    assign(save_point, 'save/save_point.dat');
    assign(save_tour, 'save/save_tour.dat');
    assign(bike_df, 'save/save_bike_damage.dat');
    assign(save_truck_master, 'save/save_truck_master.dat');
    assign(save_bikename, 'save/save_bikename.dat');
    assign(save_bikespd, 'save/save_bikespd.dat');
    assign(save_truckprice, 'save/save_truckprice.dat');
    assign(save_shop_master, 'save/save_shopmaster.dat');
  end;
  textcolor(10);SetWindowTitle('Biker');
//  if key_enable = true then begin//ПРОВЕРКА КЛЮЧА
//    write('Введите ключ-код: ');
//    while (key_try < 3) xor (not key_id = false) do 
//    begin
//      readln(key_master);
//      for var i := 1 to 100 do 
//      begin
//        write('Проверка: ', i, '%');Delay(Random(10) + 20);ClrScr;
//      end;
//      if key_master = key then begin
//        key_id := true;
//        write('Ключ принят!');
//      end
//      else begin
//        key_try := key_try + 1;
//        if key_try <> 3 then write('Ключ неверен. ');
//        case key_try of
//          1: writeln('Осталось 2 попытки.');
//          2: writeln('Осталось 1 попытка.');
//        end;
//        if key_try <> 3 then write('Введите ключ-код ещё раз: ');
//      end;
//    end;
//    if key_id = false then exit;
//  end;
//  Delay(1000);
  save_menu:
  textcolor(0);textbackground(15);
  menu_off := false;
  while menu_off = false do 
  begin
    ClrScr;menu_id_int := 999;
    writeln;if savegame = true then writeln(' (1) Продолжить игру');
    writeln(' (0) Новая игра');
    writeln(' (2) Настройки');
    writeln(' (3) Выход');
    setx := wherex;sety := wherey;
    gotoxy(48, 25);
    write('Александр Котов KTVGame 2017 год');
    gotoxy(setx, sety);
    write(' : ');readln(menu_id);
    if (menu_id = '0') or (menu_id = '1') or (menu_id = '2') or (menu_id = '3') then begin
      if menu_id = '0' then menu_id_int := 0;
      if (menu_id = '1') and (savegame = true) then menu_id_int := 1;
      if menu_id = '2' then menu_id_int := 2;
      if menu_id = '3' then menu_id_int := 3;
      case menu_id_int of
        0: goto save_newgame;
        1: goto save_loading;
        2: 
          begin
            setup_off := false;
            while setup_off = false do 
            begin
              ClrScr;
              write(' (1) Спрашивать ключ-код каждый запуск: ');if key_enable = false then writeln('нет') else writeln('да');
              writeln(' (0) Вернуться');
              write(' : ');readln(setup_id);
              if setup_id = '0' then setup_id_int := 0;
              if setup_id = '1' then setup_id_int := 1;
              case setup_id_int of
                0:  setup_off := true;
                1: 
                  begin
                    setup_key_en := false;
                    while setup_key_en = false do 
                    begin
                      ClrScr;
                      writeln(' Текущее значение: ', key_enable);
                      write(' Новое значение (true/false): ');readln(key_enable_check);
                      if (key_enable_check = 'false') or (key_enable_check = 'true') then begin
                        if key_enable_check = 'false' then key_enable := false else key_enable := true;
                        setup_key_en := true;rewrite(save_key);writeln(save_key, key_enable);close(save_key);
                      end;
                    end;
                  end;
              end;
            end;
          end;
        3: exit;
      end;
    end;
  end;
  save_newgame:
  max_spd := 25;
  avg_spd := 15;
  money := 5000;
  truck_master := 0.5;
  truck_price := 500;
  bike_name := 'Самодельный велосипед';
  shop_master := 10;
  for var i := 0 to towns do tour[i] := false;
  for var i := 1 to damages do bike_damage_flag[i] := false;
  goto save_p0;
  
  save_loading: 
  reset(save_money);readln(save_money, money);close(save_money);
  reset(save_point);readln(save_point, adv_int);close(save_point);
  reset(save_tour);for var i := 0 to towns do readln(save_tour, tour[i]);close(save_tour);
  reset(bike_df);for var i := 1 to damages do readln(bike_df, bike_damage_flag[i]);close(bike_df);
  reset(save_truck_master);readln(save_truck_master, truck_master);close(save_truck_master);
  reset(save_bikename);readln(save_bikename, bike_name);close(save_bikename);
  reset(save_bikespd);readln(save_bikespd, max_spd);readln(save_bikespd, avg_spd);close(save_bikespd);
  reset(save_truckprice);readln(save_truckprice, truck_price);close(save_truckprice);
  reset(save_shop_master);readln(save_shop_master, shop_master);close(save_shop_master);
  case adv_int of
    1: goto save_p1;
    2: goto save_p2;
    3: goto save_p3;
    4: goto save_p4;
    5: goto save_p5;
    6: goto save_p6;
    7: goto save_p7;
    8: goto save_p8;
    9: goto save_p9;
    10: goto save_p10;
    11: goto save_p11;
    12: goto save_p12;
    13: goto save_p13;
    14: goto save_p14;
    15: goto save_p15;
    16: goto save_p16;
    17: goto save_p17;
    18: goto save_p18;
    19: goto save_p19;
    20: goto save_p20;
  end;
  adventure:
  ClrScr;
  adv_off := false; adv_int := 999;
  while adv_off = false do 
  begin
    ClrScr;
    writeln('   Куда поедем?');
    for var i := 0 to towns do 
    begin
      if (town_road[current_town, i] = 1) or (town_road[current_town, i] = 2) or (town_road[current_town, i] = 3) then begin
        write(' (', i, ') ', town_name[i]);
        if town_road[current_town, i] = 1 then writeln(' (Проселочная дорога 1-3 повреждения) ');
        if town_road[current_town, i] = 2 then writeln(' (Шоссе. До 1 повреждения) ');
        if town_road[current_town, i] = 3 then writeln(' (Железная дорога. 0 повреждений, Цена: 5000 руб)');
      end;
    end;
    writeln(' (0) Никуда');
    write(' : ');readln(adv_str);
    if (adv_str = '0') then adv_int := 0;
    if (adv_str = '1') and (town_road[current_town, 1] > 0) then adv_int := 1;
    if (adv_str = '2') and (town_road[current_town, 2] > 0) then adv_int := 2;
    if (adv_str = '3') and (town_road[current_town, 3] > 0) then adv_int := 3;
    if (adv_str = '4') and (town_road[current_town, 4] > 0) then adv_int := 4;
    if (adv_str = '5') and (town_road[current_town, 5] > 0) then adv_int := 5;
    if (adv_str = '6') and (town_road[current_town, 6] > 0) then adv_int := 6;
    if (adv_str = '7') and (town_road[current_town, 7] > 0) then adv_int := 7;
    if (adv_str = '8') and (town_road[current_town, 8] > 0) then adv_int := 8;
    if (adv_str = '9') and (town_road[current_town, 9] > 0) then adv_int := 9;
    if (adv_str = '10') and (town_road[current_town, 10] > 0) then adv_int := 10;
    if (adv_str = '11') and (town_road[current_town, 11] > 0) then adv_int := 11;
    if (adv_str = '12') and (town_road[current_town, 12] > 0) then adv_int := 12;
    if (adv_str = '13') and (town_road[current_town, 13] > 0) then adv_int := 13;
    if (adv_str = '14') and (town_road[current_town, 14] > 0) then adv_int := 14;
    if (adv_str = '15') and (town_road[current_town, 15] > 0) then adv_int := 15;
    if (adv_str = '16') and (town_road[current_town, 16] > 0) then adv_int := 16;
    if (adv_str = '17') and (town_road[current_town, 17] > 0) then adv_int := 17;
    if (adv_str = '18') and (town_road[current_town, 18] > 0) then adv_int := 18;
    if (adv_str = '19') and (town_road[current_town, 19] > 0) then adv_int := 19;
    if (adv_str = '20') and (town_road[current_town, 20] > 0) then adv_int := 20;
    if (adv_int = 1) or (adv_int = 2) or (adv_int = 3) or (adv_int = 4) or (adv_int = 5) or (adv_int = 6) or (adv_int = 7) or (adv_int = 8) or (adv_int = 9) or (adv_int = 10) or (adv_int = 11) or (adv_int = 12) or (adv_int = 13) or (adv_int = 14) or (adv_int = 15) or (adv_int = 16) or (adv_int = 17) or (adv_int = 18) or (adv_int = 19) or (adv_int = 20) then begin
      randomer := random(200) + 100;
      summ:=0;
      while summ < randomer do 
      begin
        ClrScr;write('Пройдено: ', summ, ' / ', randomer);
        inc(summ, random(10) + (avg_spd - 5));Delay(500);
      end;
      ClrScr;
      case town_road[current_town, adv_int] of
        1:
          begin
            randomer := random(100);
            case randomer of
              0..74: begin randomer1 := random(damages) + 1; bike_damage_flag[randomer1] := true; writedelay(bike_damage_comment[randomer1], delayer); Delay(2500); end;
              75..89: begin randomer1 := random(damages) + 1; bike_damage_flag[randomer1] := true; writedelay(bike_damage_comment[randomer1], delayer); Delay(2500); writeln; randomer1 := random(damages) + 1; bike_damage_flag[randomer1] := true; writedelay(bike_damage_comment[randomer1], delayer); Delay(2500); end;
              90..99: begin randomer1 := random(damages) + 1; bike_damage_flag[randomer1] := true; writedelay(bike_damage_comment[randomer1], delayer); Delay(2500); writeln; randomer1 := random(damages) + 1; bike_damage_flag[randomer1] := true; writedelay(bike_damage_comment[randomer1], delayer); Delay(2500); writeln; randomer1 := random(damages) + 1; bike_damage_flag[randomer1] := true; writedelay(bike_damage_comment[randomer1], delayer); Delay(2500); end;
            end;
          end;
        2:
          begin
            randomer := random(100);
            case randomer of
              0..89: begin end;
              90..99: begin randomer1 := random(damages) + 1; bike_damage_flag[randomer1] := true; writedelay(bike_damage_comment[randomer1], delayer); Delay(2500); end;
            end;
          end;
        3: 
          begin
            if money < 5000 then begin adv_int := 0; ClrScr; writeln(' Не хватает средств'); Delay(1000); ClrScr; end;
            if money >= 5000 then Dec(money, 5000);
          end;
      end;
      if adv_int <> 0 then begin
        rewrite(save_money);writeln(save_money, money);close(save_money);
        rewrite(save_point);writeln(save_point, adv_int);close(save_point);
        rewrite(save_tour);for var i := 0 to towns do writeln(save_tour, tour[i]);close(save_tour);
        rewrite(bike_df);for var i := 1 to damages do writeln(bike_df, bike_damage_flag[i]);close(bike_df);
        rewrite(save_truck_master);writeln(save_truck_master, truck_master);close(save_truck_master);
        rewrite(save_bikename);writeln(save_bikename, bike_name);close(save_bikename);
        rewrite(save_bikespd);writeln(save_bikespd, max_spd);writeln(save_bikespd, avg_spd);close(save_bikespd);
        rewrite(save_truckprice);writeln(save_truckprice, truck_price);close(save_truckprice);
        rewrite(save_game);writeln(save_game, true);close(save_game);
        rewrite(save_shop_master);writeln(save_shop_master, shop_master);close(save_shop_master);
        truck_count := 0; race_off:=false;
        ClrScr;
        case random(2) of
          0: writedelay('Подсказка: игра сохраняется при перемещении между городами', delayer);
          1: writedelay('Подсказка: когда вы покупаете новый велосипед, все повреждения пропадают', delayer);
        end;
        Delay(500);
      end;
      case adv_int of
        1: goto save_p1;
        2: goto save_p2;
        3: goto save_p3;
        4: goto save_p4;
        5: goto save_p5;
        6: goto save_p6;
        7: goto save_p7;
        8: goto save_p8;
        9: goto save_p9;
        10: goto save_p10;
        11: goto save_p11;
        12: goto save_p12;
        13: goto save_p13;
        14: goto save_p14;
        15: goto save_p15;
        16: goto save_p16;
        17: goto save_p17;
        18: goto save_p18;
        19: goto save_p19;
        20: goto save_p20;
      end;
    end;
    if adv_int = 0 then begin
      case current_town of
        0: goto save_p0;
        1: goto save_p1;
        2: goto save_p2;
        3: goto save_p3;
        4: goto save_p4;
        5: goto save_p5;
        6: goto save_p6;
        7: goto save_p7;
        8: goto save_p8;
        9: goto save_p9;
        10: goto save_p10;
        11: goto save_p11;
        12: goto save_p12;
        13: goto save_p13;
        14: goto save_p14;
        15: goto save_p15;
        16: goto save_p16;
        17: goto save_p17;
        18: goto save_p18;
        19: goto save_p19;
        20: goto save_p20;
      end;
    end;
  end;
  
  repair:
  repair_off := false;repair_int := 999;repair_price := 0;
  repairs:=0;
  while repair_off = false do 
  begin
    ClrScr;
    for var i := 1 to damages do 
    begin
      if bike_damage_flag[i] = true then begin
        inc(repairs);writeln(' (', repairs, ') ', bike_damage_name[i]);
        inc(repair_price, bike_damage_price[i]);Delay(500);
      end;
    end;
    writeln;writespace(20);write(' К оплате: ', repair_price, ' ');writerub(repair_price);
    writeln;writespace(18);write(' У вас есть: ', money, ' ');writerub(money);writeln;
    if repair_price < money then writeln(' (1) Отремонтировать');
    writeln(' (0) Не ремонтировать');
    write(' : ');readln(repair_str);
    if repair_str = '0' then repair_int := 0;
    if (repair_str = '1') and (repair_price < money) then repair_int := 1;
    case repair_int of
      0: repair_off := true;
      1: 
        begin
          Dec(money, repair_price);
          for var i := 1 to damages do bike_damage_flag[i] := false;
          repair_off := true;
        end;
    end;
  end;
  case current_town of
    0: goto save_p0;
    1: goto save_p1;
    2: goto save_p2;
    3: goto save_p3;
    4: goto save_p4;
    5: goto save_p5;
    6: goto save_p6;
    7: goto save_p7;
    8: goto save_p8;
    9: goto save_p9;
    10: goto save_p10;
    11: goto save_p11;
    12: goto save_p12;
    13: goto save_p13;
    14: goto save_p14;
    15: goto save_p15;
    16: goto save_p16;
    17: goto save_p17;
    18: goto save_p18;
    19: goto save_p19;
    20: goto save_p20;
  end;
  
  bike_shop:
  //shop_off: boolean; shop_name, shop_str: string; shop_avg_spd, shop_max_spd, shop_price, shop_int: integer;
  shop_off := false;shop_int := 999;ClrScr;
  while shop_off = false do 
  begin
    ClrScr;
    shop_name := names_bike[random(57) + 1];
    shop_max_spd := random(15) + shop_master + 10;
    shop_avg_spd := shop_max_spd - 10 - random(5);
    shop_price := (random(1500) + 750) * 10;
    writeln(' Магазин города ', town_name[current_town]);
    writeln(' Велосипед "', shop_name, '"');
    writeln(' Максимальная скорость: ', shop_max_spd);
    writeln(' Средняя скорость: ', shop_avg_spd);
    writespace(18); write(' Цена: ', shop_price, ' ');writerub(shop_price);writeln;
    writespace(12); write(' У вас есть: ', money, ' ');writerub(money);writeln;
    if shop_price < money then writeln(' (1) Купить');
    writeln(' (2) Следующий велосипед');
    writeln(' (0) Покинуть магазин');
    shop_read: ClearLine; write(' : '); readln(shop_str); GotoXY(WhereX, WhereY - 1);
    if shop_str = '0' then shop_int := 0;
    if (shop_str = '1') and (shop_price < money) then shop_int := 1;
    if shop_str = '2' then shop_int := 2;
    if ((shop_str <> '0') and (shop_str <> '1') and (shop_str <> '2')) or ((shop_str = '1') and (money < shop_price)) then goto shop_read;
    case shop_int of
      0: shop_off := true;
      1: 
        begin
          bike_name := shop_name;
          avg_spd := shop_avg_spd;
          max_spd := shop_max_spd;
          Dec(money, shop_price);
          for var i := 1 to damages do bike_damage_flag[i] := false;
          shop_off := true;
        end;
    end;
  end;
  case current_town of
    0: goto save_p0;
    1: goto save_p1;
    2: goto save_p2;
    3: goto save_p3;
    4: goto save_p4;
    5: goto save_p5;
    6: goto save_p6;
    7: goto save_p7;
    8: goto save_p8;
    9: goto save_p9;
    10: goto save_p10;
    11: goto save_p11;
    12: goto save_p12;
    13: goto save_p13;
    14: goto save_p14;
    15: goto save_p15;
    16: goto save_p16;
    17: goto save_p17;
    18: goto save_p18;
    19: goto save_p19;
    20: goto save_p20;
  end;
  
  trucks:
  ClrScr;
  if truck_count < 4 then begin
    truck_money := trunc((random(5000)) * truck_master);
    truck_master := truck_master + 0.0005; inc(truck_count);
    write('Получено: ', truck_money, ' ');writerub(truck_money);
    inc(money, truck_money);Delay(2500);
  end;
  case current_town of
    0: goto save_p0;
    1: goto save_p1;
    2: goto save_p2;
    3: goto save_p3;
    4: goto save_p4;
    5: goto save_p5;
    6: goto save_p6;
    7: goto save_p7;
    8: goto save_p8;
    9: goto save_p9;
    10: goto save_p10;
    11: goto save_p11;
    12: goto save_p12;
    13: goto save_p13;
    14: goto save_p14;
    15: goto save_p15;
    16: goto save_p16;
    17: goto save_p17;
    18: goto save_p18;
    19: goto save_p19;
    20: goto save_p20;
  end;
  
  truck_school:
  ClrScr; school_int := 999; school_off := false;
  while school_off = false do 
  begin
    ClrScr;
    writeln('Школа города ', town_name[current_town]);
    writeln('Текущее мастерство: ', truck_master * 100, '%');
    write('Деньги: ', money, ' ');writerub(money);writeln;
    if truck_price < money then begin write(' (1) Уличный курс [+0.5%] ', truck_price, ' '); writerub(truck_price); writeln; end;
    if truck_price * 2 < money then begin write(' (2) Стандартный курс [+1%] ', truck_price * 2, ' '); writerub(truck_price * 2); writeln; end;
    if truck_price * 3 < money then begin write(' (3) Улучшенный курс [+2%] ', truck_price * 3, ' '); writerub(truck_price * 3); writeln; end;
    if truck_price * 5 < money then begin write(' (4) Профессиональный курс [+3%] ', truck_price * 5, ' '); writerub(truck_price * 5); writeln; end;
    if truck_price * 7 < money then begin write(' (5) Мастерский курс [+5%] ', truck_price * 7, ' '); writerub(truck_price * 7); writeln; end;
    writeln(' (0) Вернуться');
    write(' : ');readln(school_str);
    if school_str = '0' then school_int := 0;
    if (school_str = '1') and (truck_price < money) then school_int := 1;
    if (school_str = '2') and (truck_price * 2 < money) then school_int := 2;
    if (school_str = '3') and (truck_price * 3 < money) then school_int := 3;
    if (school_str = '4') and (truck_price * 5 < money) then school_int := 4;
    if (school_str = '5') and (truck_price * 7 < money) then school_int := 5;
    if (school_int = 1) or (school_int = 2) or (school_int = 3) or (school_int = 4) or (school_int = 5) then begin
      case school_int of
        1:
          begin
            dec(money, truck_price);truck_master := truck_master + 0.005;inc(truck_price,100);
          end;
        2:
          begin
            dec(money, truck_price * 2);truck_master := truck_master + 0.01;inc(truck_price,100);
          end;
        3:
          begin
            dec(money, truck_price * 3);truck_master := truck_master + 0.02;inc(truck_price,100);
          end;
        4:
          begin
            dec(money, truck_price * 5);truck_master := truck_master + 0.03;inc(truck_price,100);
          end;
        5:
          begin
            dec(money, truck_price * 7);truck_master := truck_master + 0.05;inc(truck_price,100);
          end;
      end;
    end;
    if school_int = 0 then school_off := true;
  end;
  case current_town of
    0: goto save_p0;
    1: goto save_p1;
    2: goto save_p2;
    3: goto save_p3;
    4: goto save_p4;
    5: goto save_p5;
    6: goto save_p6;
    7: goto save_p7;
    8: goto save_p8;
    9: goto save_p9;
    10: goto save_p10;
    11: goto save_p11;
    12: goto save_p12;
    13: goto save_p13;
    14: goto save_p14;
    15: goto save_p15;
    16: goto save_p16;
    17: goto save_p17;
    18: goto save_p18;
    19: goto save_p19;
    20: goto save_p20;
  end;
  race:
  ClrScr;
  if race_off = false then begin
  race_max1 := random(30) + 15;
  race_max2 := random(30) + 15;
  race_max3 := random(30) + 15;
  race_max4 := random(30) + 15;
  race_avg1 := race_max1 - random(10);
  race_avg2 := race_max2 - random(10);
  race_avg3 := race_max3 - random(10);
  race_avg4 := race_max4 - random(10);
  prop1 := race_max1 * race_avg1;
  prop2 := race_max2 * race_avg2;
  prop3 := race_max3 * race_avg3;
  prop4 := race_max4 * race_avg4;
  prop5 := avg_spd * max_spd;
  writeln('Гонщик   | Ср.Ск. | Макс.ск');Delay(500);
  writeln('Гонщик 1 | ', race_avg1:6, ' | ', race_max1:6);Delay(500);
  writeln('Гонщик 2 | ', race_avg2:6, ' | ', race_max2:6);Delay(500);
  writeln('Гонщик 3 | ', race_avg3:6, ' | ', race_max3:6);Delay(500);
  writeln('Гонщик 4 | ', race_avg4:6, ' | ', race_max4:6);Delay(500);
  writeln('Вы       | ', avg_spd:6, ' | ', max_spd:6);Delay(2000);ClrScr;
  for var i := 1 to 100 do 
  begin
    write('Гонка: ', i, '%');Delay(Random(40) + 30);ClrScr;
  end;
  if (prop5 >= prop1) and (prop5 >= prop2) and (prop5 >= prop3) and (prop5 >= prop4) then begin
    race_money:=random(10000)+5000;
    writeln('ВЫ ПОБЕДИЛИ! НАГРАДА: ',race_money,' ');writerub(race_money);inc(money,race_money);delay(2500);ClrScr;
    race_off:=true;
  end
  else begin
    writeln('ВЫ ПРОИГРАЛИ!');delay(2500);ClrScr;
    race_off:=true;
  end;
  end;
  case current_town of
    0: goto save_p0;
    1: goto save_p1;
    2: goto save_p2;
    3: goto save_p3;
    4: goto save_p4;
    5: goto save_p5;
    6: goto save_p6;
    7: goto save_p7;
    8: goto save_p8;
    9: goto save_p9;
    10: goto save_p10;
    11: goto save_p11;
    12: goto save_p12;
    13: goto save_p13;
    14: goto save_p14;
    15: goto save_p15;
    16: goto save_p16;
    17: goto save_p17;
    18: goto save_p18;
    19: goto save_p19;
    20: goto save_p20;
  end;
  save_p0: current_town := 0;ClrScr;
  if tour[current_town] = false then begin
    writedelay('Уезжай-ка ты из этого Урюпинска. Ты отлично катаешься на велике, на большой земле ты сможешь гораздо большему научиться.', delayer);writeln;
    writedelay('Я уже слишком стар что бы ехать с тобой... Поезжай в Строгачёво. Сперва в Подбережный, потом в Мухтарск, а после уже в Строгачёво. Удачи тебе.', delayer);writeln;
    tour[current_town] := true;Delay(3000);
    inc(shop_master);
  end;
  point_off := false;point_int := 999;
  while point_off = false do 
  begin
    ClrScr;
    writeln('   Состояние велосипеда ', bike_name);
    write('   Наличие повреждений: ');if (bike_damage_flag[1] = false) and (bike_damage_flag[2] = false) and (bike_damage_flag[3] = false) and (bike_damage_flag[4] = false) and (bike_damage_flag[5] = false) and (bike_damage_flag[6] = false) and (bike_damage_flag[7] = false) and (bike_damage_flag[8] = false) and (bike_damage_flag[9] = false) and (bike_damage_flag[10] = false) and (bike_damage_flag[11] = false) and (bike_damage_flag[12] = false) and (bike_damage_flag[13] = false) and (bike_damage_flag[14] = false) and (bike_damage_flag[15] = false) and (bike_damage_flag[16] = false) and (bike_damage_flag[17] = false) and (bike_damage_flag[18] = false) and (bike_damage_flag[19] = false) and (bike_damage_flag[20] = false) and (bike_damage_flag[21] = false) and (bike_damage_flag[22] = false) and (bike_damage_flag[23] = false) and (bike_damage_flag[24] = false) and (bike_damage_flag[25] = false) and (bike_damage_flag[26] = false) and (bike_damage_flag[27] = false) and (bike_damage_flag[28] = false) and (bike_damage_flag[29] = false) and (bike_damage_flag[30] = false) and (bike_damage_flag[31] = false) and (bike_damage_flag[32] = false) and (bike_damage_flag[33] = false) and (bike_damage_flag[34] = false) and (bike_damage_flag[35] = false) and (bike_damage_flag[36] = false) and (bike_damage_flag[37] = false) and (bike_damage_flag[38] = false) and (bike_damage_flag[39] = false) and (bike_damage_flag[40] = false) then writeln('нет') else writeln('есть');
    writeln('   Макс. скорость: ', max_spd);
    writeln('   Средняя скорость: ', avg_spd);writeln;
    writeln;
    writeln('   Остальные параметры');
    writeln(' Текущий город: ', town_name[current_town]);
    writeln(' Деньги: ', money);
    writeln(' Уровень мастерства трюков: ', truck_master * 100, '%');
    writeln;
    writeln(' (1) Отправиться в другой город');
    writeln(' (0) Выйти в меню');
    write(' : ');readln(point_str);
    if (point_str = '0') or (point_str = '1') then begin
      if point_str = '0' then point_int := 0;
      if point_str = '1' then point_int := 1;
      case point_int of
        0: goto save_menu;
        1: goto adventure;
      end;
      point_off := true;
    end;
  end;
  
  save_p1: current_town := 1;ClrScr;
  if tour[current_town] = false then begin
    writedelay('Подбережный... Город, который когда-то был лучшим курортом округа.', delayer);writeln;
    tour[current_town] := true;Delay(3000);
    inc(shop_master);
  end;
  point_off := false;point_int := 999;
  while point_off = false do 
  begin
    ClrScr;
    writeln('   Состояние велосипеда ', bike_name);
    write('   Наличие повреждений: ');if (bike_damage_flag[1] = false) and (bike_damage_flag[2] = false) and (bike_damage_flag[3] = false) and (bike_damage_flag[4] = false) and (bike_damage_flag[5] = false) and (bike_damage_flag[6] = false) and (bike_damage_flag[7] = false) and (bike_damage_flag[8] = false) and (bike_damage_flag[9] = false) and (bike_damage_flag[10] = false) and (bike_damage_flag[11] = false) and (bike_damage_flag[12] = false) and (bike_damage_flag[13] = false) and (bike_damage_flag[14] = false) and (bike_damage_flag[15] = false) and (bike_damage_flag[16] = false) and (bike_damage_flag[17] = false) and (bike_damage_flag[18] = false) and (bike_damage_flag[19] = false) and (bike_damage_flag[20] = false) and (bike_damage_flag[21] = false) and (bike_damage_flag[22] = false) and (bike_damage_flag[23] = false) and (bike_damage_flag[24] = false) and (bike_damage_flag[25] = false) and (bike_damage_flag[26] = false) and (bike_damage_flag[27] = false) and (bike_damage_flag[28] = false) and (bike_damage_flag[29] = false) and (bike_damage_flag[30] = false) and (bike_damage_flag[31] = false) and (bike_damage_flag[32] = false) and (bike_damage_flag[33] = false) and (bike_damage_flag[34] = false) and (bike_damage_flag[35] = false) and (bike_damage_flag[36] = false) and (bike_damage_flag[37] = false) and (bike_damage_flag[38] = false) and (bike_damage_flag[39] = false) and (bike_damage_flag[40] = false) then writeln('нет') else writeln('есть');
    writeln('   Макс. скорость: ', max_spd);
    writeln('   Средняя скорость: ', avg_spd);writeln;
    writeln;
    writeln('   Остальные параметры');
    writeln(' Текущий город: ', town_name[current_town]);
    writeln(' Деньги: ', money);
    writeln(' Уровень мастерства трюков: ', truck_master * 100, '%');
    writeln;
    writeln(' (1) Отправиться в другой город');
    writeln(' (2) Ремонтная мастерская');
    writeln(' (3) Магазин велосипедов');
    writeln(' (4) Школа каскадёрства');
    writeln(' (0) Выйти в меню');
    write(' : ');readln(point_str);
    if (point_str = '0') or (point_str = '1') or (point_str = '2') or (point_str = '3') or (point_str = '4') then begin
      if point_str = '0' then point_int := 0;
      if point_str = '1' then point_int := 1;
      if point_str = '2' then point_int := 2;
      if point_str = '3' then point_int := 3;
      if point_str = '4' then point_int := 4;
      case point_int of
        0: goto save_menu;
        1: goto adventure;
        2: goto repair;
        3: goto bike_shop;
        4: goto truck_school;
      end;
      point_off := true;
    end;
  end;
  
  save_p2: current_town := 2;ClrScr;
  if tour[current_town] = false then begin
    writedelay('Мухтарск. Злдесь дрессируют бойцовских собак ', delayer);writeln;
    writedelay('Дальше в строгачёво.', delayer);writeln;
    tour[current_town] := true;Delay(3000);
    inc(shop_master);
  end;
  point_off := false;point_int := 999;
  while point_off = false do 
  begin
    ClrScr;
    writeln('   Состояние велосипеда ', bike_name);
    write('   Наличие повреждений: ');if (bike_damage_flag[1] = false) and (bike_damage_flag[2] = false) and (bike_damage_flag[3] = false) and (bike_damage_flag[4] = false) and (bike_damage_flag[5] = false) and (bike_damage_flag[6] = false) and (bike_damage_flag[7] = false) and (bike_damage_flag[8] = false) and (bike_damage_flag[9] = false) and (bike_damage_flag[10] = false) and (bike_damage_flag[11] = false) and (bike_damage_flag[12] = false) and (bike_damage_flag[13] = false) and (bike_damage_flag[14] = false) and (bike_damage_flag[15] = false) and (bike_damage_flag[16] = false) and (bike_damage_flag[17] = false) and (bike_damage_flag[18] = false) and (bike_damage_flag[19] = false) and (bike_damage_flag[20] = false) and (bike_damage_flag[21] = false) and (bike_damage_flag[22] = false) and (bike_damage_flag[23] = false) and (bike_damage_flag[24] = false) and (bike_damage_flag[25] = false) and (bike_damage_flag[26] = false) and (bike_damage_flag[27] = false) and (bike_damage_flag[28] = false) and (bike_damage_flag[29] = false) and (bike_damage_flag[30] = false) and (bike_damage_flag[31] = false) and (bike_damage_flag[32] = false) and (bike_damage_flag[33] = false) and (bike_damage_flag[34] = false) and (bike_damage_flag[35] = false) and (bike_damage_flag[36] = false) and (bike_damage_flag[37] = false) and (bike_damage_flag[38] = false) and (bike_damage_flag[39] = false) and (bike_damage_flag[40] = false) then writeln('нет') else writeln('есть');
    writeln('   Макс. скорость: ', max_spd);
    writeln('   Средняя скорость: ', avg_spd);writeln;
    writeln;
    writeln('   Остальные параметры');
    writeln(' Текущий город: ', town_name[current_town]);
    writeln(' Деньги: ', money);
    writeln(' Уровень мастерства трюков: ', truck_master * 100, '%');
    writeln;
    writeln(' (1) Отправиться в другой город');
    writeln(' (2) Ремонтная мастерская');
    writeln(' (3) Магазин велосипедов');
    writeln(' (0) Выйти в меню');
    write(' : ');readln(point_str);
    if (point_str = '0') or (point_str = '1') or (point_str = '2') or (point_str = '3') then begin
      if point_str = '0' then point_int := 0;
      if point_str = '1' then point_int := 1;
      if point_str = '2' then point_int := 2;
      if point_str = '3' then point_int := 3;
      case point_int of
        0: goto save_menu;
        1: goto adventure;
        2: goto repair;
        3: goto bike_shop;
      end;
      point_off := true;
    end;
  end;
  
  save_p3: current_town := 3;ClrScr;
  if tour[current_town] = false then begin
    writedelay('Панино. Знаменито своими кинологами.', delayer);writeln;
    tour[current_town] := true;Delay(3000);
    inc(shop_master);
  end;
  point_off := false;point_int := 999;
  while point_off = false do 
  begin
    ClrScr;
    writeln('   Состояние велосипеда ', bike_name);
    write('   Наличие повреждений: ');if (bike_damage_flag[1] = false) and (bike_damage_flag[2] = false) and (bike_damage_flag[3] = false) and (bike_damage_flag[4] = false) and (bike_damage_flag[5] = false) and (bike_damage_flag[6] = false) and (bike_damage_flag[7] = false) and (bike_damage_flag[8] = false) and (bike_damage_flag[9] = false) and (bike_damage_flag[10] = false) and (bike_damage_flag[11] = false) and (bike_damage_flag[12] = false) and (bike_damage_flag[13] = false) and (bike_damage_flag[14] = false) and (bike_damage_flag[15] = false) and (bike_damage_flag[16] = false) and (bike_damage_flag[17] = false) and (bike_damage_flag[18] = false) and (bike_damage_flag[19] = false) and (bike_damage_flag[20] = false) and (bike_damage_flag[21] = false) and (bike_damage_flag[22] = false) and (bike_damage_flag[23] = false) and (bike_damage_flag[24] = false) and (bike_damage_flag[25] = false) and (bike_damage_flag[26] = false) and (bike_damage_flag[27] = false) and (bike_damage_flag[28] = false) and (bike_damage_flag[29] = false) and (bike_damage_flag[30] = false) and (bike_damage_flag[31] = false) and (bike_damage_flag[32] = false) and (bike_damage_flag[33] = false) and (bike_damage_flag[34] = false) and (bike_damage_flag[35] = false) and (bike_damage_flag[36] = false) and (bike_damage_flag[37] = false) and (bike_damage_flag[38] = false) and (bike_damage_flag[39] = false) and (bike_damage_flag[40] = false) then writeln('нет') else writeln('есть');
    writeln('   Макс. скорость: ', max_spd);
    writeln('   Средняя скорость: ', avg_spd);writeln;
    writeln;
    writeln('   Остальные параметры');
    writeln(' Текущий город: ', town_name[current_town]);
    writeln(' Деньги: ', money);
    writeln(' Уровень мастерства трюков: ', truck_master * 100, '%');
    writeln;
    writeln(' (1) Отправиться в другой город');
    writeln(' (2) Ремонтная мастерская');
    writeln(' (0) Выйти в меню');
    write(' : ');readln(point_str);
    if (point_str = '0') or (point_str = '1') or (point_str = '2') then begin
      if point_str = '0' then point_int := 0;
      if point_str = '1' then point_int := 1;
      if point_str = '2' then point_int := 2;
      case point_int of
        0: goto save_menu;
        1: goto adventure;
        2: goto repair;
      end;
      point_off := true;
    end;
  end;
  
  save_p4: current_town := 4;ClrScr;
  if tour[current_town] = false then begin
    writedelay('Вот и Строгачёво. Ближайший от Урюпинска город с каскадёрской ареной', delayer);writeln;
    tour[current_town] := true;Delay(3000);
    inc(shop_master);
  end;
  point_off := false;point_int := 999;
  while point_off = false do 
  begin
    ClrScr;
    writeln('   Состояние велосипеда ', bike_name);
    write('   Наличие повреждений: ');if (bike_damage_flag[1] = false) and (bike_damage_flag[2] = false) and (bike_damage_flag[3] = false) and (bike_damage_flag[4] = false) and (bike_damage_flag[5] = false) and (bike_damage_flag[6] = false) and (bike_damage_flag[7] = false) and (bike_damage_flag[8] = false) and (bike_damage_flag[9] = false) and (bike_damage_flag[10] = false) and (bike_damage_flag[11] = false) and (bike_damage_flag[12] = false) and (bike_damage_flag[13] = false) and (bike_damage_flag[14] = false) and (bike_damage_flag[15] = false) and (bike_damage_flag[16] = false) and (bike_damage_flag[17] = false) and (bike_damage_flag[18] = false) and (bike_damage_flag[19] = false) and (bike_damage_flag[20] = false) and (bike_damage_flag[21] = false) and (bike_damage_flag[22] = false) and (bike_damage_flag[23] = false) and (bike_damage_flag[24] = false) and (bike_damage_flag[25] = false) and (bike_damage_flag[26] = false) and (bike_damage_flag[27] = false) and (bike_damage_flag[28] = false) and (bike_damage_flag[29] = false) and (bike_damage_flag[30] = false) and (bike_damage_flag[31] = false) and (bike_damage_flag[32] = false) and (bike_damage_flag[33] = false) and (bike_damage_flag[34] = false) and (bike_damage_flag[35] = false) and (bike_damage_flag[36] = false) and (bike_damage_flag[37] = false) and (bike_damage_flag[38] = false) and (bike_damage_flag[39] = false) and (bike_damage_flag[40] = false) then writeln('нет') else writeln('есть');
    writeln('   Макс. скорость: ', max_spd);
    writeln('   Средняя скорость: ', avg_spd);writeln;
    writeln;
    writeln('   Остальные параметры');
    writeln(' Текущий город: ', town_name[current_town]);
    writeln(' Деньги: ', money);
    writeln(' Уровень мастерства трюков: ', truck_master * 100, '%');
    writeln;
    writeln(' (1) Отправиться в другой город');
    writeln(' (2) Каскадёрская арена');
    writeln(' (0) Выйти в меню');
    write(' : ');readln(point_str);
    if (point_str = '0') or (point_str = '1') or (point_str = '2') then begin
      if point_str = '0' then point_int := 0;
      if point_str = '1' then point_int := 1;
      if point_str = '2' then point_int := 2;
      case point_int of
        0: goto save_menu;
        1: goto adventure;
        2: goto trucks;
      end;
      point_off := true;
    end;
  end;
  
  save_p5: current_town := 5;ClrScr;
  if tour[current_town] = false then begin
    writedelay('Гадово. Много змей. Здешний змеиный яд пользуется огромным спросом у медиков', delayer);writeln;
    tour[current_town] := true;Delay(3000);
    inc(shop_master);
  end;
  point_off := false;point_int := 999;
  while point_off = false do 
  begin
    ClrScr;
    writeln('   Состояние велосипеда ', bike_name);
    write('   Наличие повреждений: ');if (bike_damage_flag[1] = false) and (bike_damage_flag[2] = false) and (bike_damage_flag[3] = false) and (bike_damage_flag[4] = false) and (bike_damage_flag[5] = false) and (bike_damage_flag[6] = false) and (bike_damage_flag[7] = false) and (bike_damage_flag[8] = false) and (bike_damage_flag[9] = false) and (bike_damage_flag[10] = false) and (bike_damage_flag[11] = false) and (bike_damage_flag[12] = false) and (bike_damage_flag[13] = false) and (bike_damage_flag[14] = false) and (bike_damage_flag[15] = false) and (bike_damage_flag[16] = false) and (bike_damage_flag[17] = false) and (bike_damage_flag[18] = false) and (bike_damage_flag[19] = false) and (bike_damage_flag[20] = false) and (bike_damage_flag[21] = false) and (bike_damage_flag[22] = false) and (bike_damage_flag[23] = false) and (bike_damage_flag[24] = false) and (bike_damage_flag[25] = false) and (bike_damage_flag[26] = false) and (bike_damage_flag[27] = false) and (bike_damage_flag[28] = false) and (bike_damage_flag[29] = false) and (bike_damage_flag[30] = false) and (bike_damage_flag[31] = false) and (bike_damage_flag[32] = false) and (bike_damage_flag[33] = false) and (bike_damage_flag[34] = false) and (bike_damage_flag[35] = false) and (bike_damage_flag[36] = false) and (bike_damage_flag[37] = false) and (bike_damage_flag[38] = false) and (bike_damage_flag[39] = false) and (bike_damage_flag[40] = false) then writeln('нет') else writeln('есть');
    writeln('   Макс. скорость: ', max_spd);
    writeln('   Средняя скорость: ', avg_spd);writeln;
    writeln;
    writeln('   Остальные параметры');
    writeln(' Текущий город: ', town_name[current_town]);
    writeln(' Деньги: ', money);
    writeln(' Уровень мастерства трюков: ', truck_master * 100, '%');
    writeln;
    writeln(' (1) Отправиться в другой город');
    writeln(' (2) Магазин велосипедов');
    writeln(' (0) Выйти в меню');
    write(' : ');readln(point_str);
    if (point_str = '0') or (point_str = '1') or (point_str = '2') then begin
      if point_str = '0' then point_int := 0;
      if point_str = '1' then point_int := 1;
      if point_str = '2' then point_int := 2;
      case point_int of
        0: goto save_menu;
        1: goto adventure;
        2: goto bike_shop;
      end;
      point_off := true;
    end;
  end;
  
  save_p6: current_town := 6;ClrScr;
  if tour[current_town] = false then begin
    writedelay('В Зубово самые дешёвые стоматологические услуги.', delayer);writeln;
    tour[current_town] := true;Delay(3000);
    inc(shop_master);
  end;
  point_off := false;point_int := 999;
  while point_off = false do 
  begin
    ClrScr;
    writeln('   Состояние велосипеда ', bike_name);
    write('   Наличие повреждений: ');if (bike_damage_flag[1] = false) and (bike_damage_flag[2] = false) and (bike_damage_flag[3] = false) and (bike_damage_flag[4] = false) and (bike_damage_flag[5] = false) and (bike_damage_flag[6] = false) and (bike_damage_flag[7] = false) and (bike_damage_flag[8] = false) and (bike_damage_flag[9] = false) and (bike_damage_flag[10] = false) and (bike_damage_flag[11] = false) and (bike_damage_flag[12] = false) and (bike_damage_flag[13] = false) and (bike_damage_flag[14] = false) and (bike_damage_flag[15] = false) and (bike_damage_flag[16] = false) and (bike_damage_flag[17] = false) and (bike_damage_flag[18] = false) and (bike_damage_flag[19] = false) and (bike_damage_flag[20] = false) and (bike_damage_flag[21] = false) and (bike_damage_flag[22] = false) and (bike_damage_flag[23] = false) and (bike_damage_flag[24] = false) and (bike_damage_flag[25] = false) and (bike_damage_flag[26] = false) and (bike_damage_flag[27] = false) and (bike_damage_flag[28] = false) and (bike_damage_flag[29] = false) and (bike_damage_flag[30] = false) and (bike_damage_flag[31] = false) and (bike_damage_flag[32] = false) and (bike_damage_flag[33] = false) and (bike_damage_flag[34] = false) and (bike_damage_flag[35] = false) and (bike_damage_flag[36] = false) and (bike_damage_flag[37] = false) and (bike_damage_flag[38] = false) and (bike_damage_flag[39] = false) and (bike_damage_flag[40] = false) then writeln('нет') else writeln('есть');
    writeln('   Макс. скорость: ', max_spd);
    writeln('   Средняя скорость: ', avg_spd);writeln;
    writeln;
    writeln('   Остальные параметры');
    writeln(' Текущий город: ', town_name[current_town]);
    writeln(' Деньги: ', money);
    writeln(' Уровень мастерства трюков: ', truck_master * 100, '%');
    writeln;
    writeln(' (1) Отправиться в другой город');
    writeln(' (2) Ремонтная мастерская');
    writeln(' (0) Выйти в меню');
    write(' : ');readln(point_str);
    if (point_str = '0') or (point_str = '1') or (point_str = '2') then begin
      if point_str = '0' then point_int := 0;
      if point_str = '1' then point_int := 1;
      if point_str = '2' then point_int := 2;
      case point_int of
        0: goto save_menu;
        1: goto adventure;
        2: goto repair;
      end;
      point_off := true;
    end;
  end;
  
  save_p7: current_town := 7;ClrScr;
  if tour[current_town] = false then begin
    writedelay('Донино названо в честь местного героя - Ильи Донина.', delayer);writeln;
    writedelay('Говорят, тот обладал такой силой, что запросто бы поднял двухтонную машину.', delayer);writeln;
    tour[current_town] := true;Delay(3000);
    inc(shop_master);
  end;
  point_off := false;point_int := 999;
  while point_off = false do 
  begin
    ClrScr;
    writeln('   Состояние велосипеда ', bike_name);
    write('   Наличие повреждений: ');if (bike_damage_flag[1] = false) and (bike_damage_flag[2] = false) and (bike_damage_flag[3] = false) and (bike_damage_flag[4] = false) and (bike_damage_flag[5] = false) and (bike_damage_flag[6] = false) and (bike_damage_flag[7] = false) and (bike_damage_flag[8] = false) and (bike_damage_flag[9] = false) and (bike_damage_flag[10] = false) and (bike_damage_flag[11] = false) and (bike_damage_flag[12] = false) and (bike_damage_flag[13] = false) and (bike_damage_flag[14] = false) and (bike_damage_flag[15] = false) and (bike_damage_flag[16] = false) and (bike_damage_flag[17] = false) and (bike_damage_flag[18] = false) and (bike_damage_flag[19] = false) and (bike_damage_flag[20] = false) and (bike_damage_flag[21] = false) and (bike_damage_flag[22] = false) and (bike_damage_flag[23] = false) and (bike_damage_flag[24] = false) and (bike_damage_flag[25] = false) and (bike_damage_flag[26] = false) and (bike_damage_flag[27] = false) and (bike_damage_flag[28] = false) and (bike_damage_flag[29] = false) and (bike_damage_flag[30] = false) and (bike_damage_flag[31] = false) and (bike_damage_flag[32] = false) and (bike_damage_flag[33] = false) and (bike_damage_flag[34] = false) and (bike_damage_flag[35] = false) and (bike_damage_flag[36] = false) and (bike_damage_flag[37] = false) and (bike_damage_flag[38] = false) and (bike_damage_flag[39] = false) and (bike_damage_flag[40] = false) then writeln('нет') else writeln('есть');
    writeln('   Макс. скорость: ', max_spd);
    writeln('   Средняя скорость: ', avg_spd);writeln;
    writeln;
    writeln('   Остальные параметры');
    writeln(' Текущий город: ', town_name[current_town]);
    writeln(' Деньги: ', money);
    writeln(' Уровень мастерства трюков: ', truck_master * 100, '%');
    writeln;
    writeln(' (1) Отправиться в другой город');
    writeln(' (2) Школа каскадёрства');
    writeln(' (0) Выйти в меню');
    write(' : ');readln(point_str);
    if (point_str = '0') or (point_str = '1') or (point_str = '2') then begin
      if point_str = '0' then point_int := 0;
      if point_str = '1' then point_int := 1;
      if point_str = '2' then point_int := 2;
      case point_int of
        0: goto save_menu;
        1: goto adventure;
        2: goto truck_school;
      end;
      point_off := true;
    end;
  end;
  
  save_p8: current_town := 8;ClrScr;
  if tour[current_town] = false then begin
    writedelay('Конево - город биологов. Кроме того, некоторые жители частенько продают нелегальные растения', delayer);writeln;
    tour[current_town] := true;Delay(3000);
    inc(shop_master);
  end;
  point_off := false;point_int := 999;
  while point_off = false do 
  begin
    ClrScr;
    writeln('   Состояние велосипеда ', bike_name);
    write('   Наличие повреждений: ');if (bike_damage_flag[1] = false) and (bike_damage_flag[2] = false) and (bike_damage_flag[3] = false) and (bike_damage_flag[4] = false) and (bike_damage_flag[5] = false) and (bike_damage_flag[6] = false) and (bike_damage_flag[7] = false) and (bike_damage_flag[8] = false) and (bike_damage_flag[9] = false) and (bike_damage_flag[10] = false) and (bike_damage_flag[11] = false) and (bike_damage_flag[12] = false) and (bike_damage_flag[13] = false) and (bike_damage_flag[14] = false) and (bike_damage_flag[15] = false) and (bike_damage_flag[16] = false) and (bike_damage_flag[17] = false) and (bike_damage_flag[18] = false) and (bike_damage_flag[19] = false) and (bike_damage_flag[20] = false) and (bike_damage_flag[21] = false) and (bike_damage_flag[22] = false) and (bike_damage_flag[23] = false) and (bike_damage_flag[24] = false) and (bike_damage_flag[25] = false) and (bike_damage_flag[26] = false) and (bike_damage_flag[27] = false) and (bike_damage_flag[28] = false) and (bike_damage_flag[29] = false) and (bike_damage_flag[30] = false) and (bike_damage_flag[31] = false) and (bike_damage_flag[32] = false) and (bike_damage_flag[33] = false) and (bike_damage_flag[34] = false) and (bike_damage_flag[35] = false) and (bike_damage_flag[36] = false) and (bike_damage_flag[37] = false) and (bike_damage_flag[38] = false) and (bike_damage_flag[39] = false) and (bike_damage_flag[40] = false) then writeln('нет') else writeln('есть');
    writeln('   Макс. скорость: ', max_spd);
    writeln('   Средняя скорость: ', avg_spd);writeln;
    writeln;
    writeln('   Остальные параметры');
    writeln(' Текущий город: ', town_name[current_town]);
    writeln(' Деньги: ', money);
    writeln(' Уровень мастерства трюков: ', truck_master * 100, '%');
    writeln;
    writeln(' (1) Отправиться в другой город');
    writeln(' (2) Ремонтная мастерская');
    writeln(' (0) Выйти в меню');
    write(' : ');readln(point_str);
    if (point_str = '0') or (point_str = '1') or (point_str = '2') then begin
      if point_str = '0' then point_int := 0;
      if point_str = '1' then point_int := 1;
      if point_str = '2' then point_int := 2;
      case point_int of
        0: goto save_menu;
        1: goto adventure;
        2: goto repair;
      end;
      point_off := true;
    end;
  end;
  
  save_p9: current_town := 9;ClrScr;
  if tour[current_town] = false then begin
    writedelay('Бердянск - столица округа. Хотя, раньше он не был столицей.', delayer);writeln;
    writedelay('Первой столицей округа был Иркутск', delayer);writeln;
    tour[current_town] := true;Delay(3000);
    inc(shop_master);
  end;
  point_off := false;point_int := 999;
  while point_off = false do 
  begin
    ClrScr;
    writeln('   Состояние велосипеда ', bike_name);
    write('   Наличие повреждений: ');if (bike_damage_flag[1] = false) and (bike_damage_flag[2] = false) and (bike_damage_flag[3] = false) and (bike_damage_flag[4] = false) and (bike_damage_flag[5] = false) and (bike_damage_flag[6] = false) and (bike_damage_flag[7] = false) and (bike_damage_flag[8] = false) and (bike_damage_flag[9] = false) and (bike_damage_flag[10] = false) and (bike_damage_flag[11] = false) and (bike_damage_flag[12] = false) and (bike_damage_flag[13] = false) and (bike_damage_flag[14] = false) and (bike_damage_flag[15] = false) and (bike_damage_flag[16] = false) and (bike_damage_flag[17] = false) and (bike_damage_flag[18] = false) and (bike_damage_flag[19] = false) and (bike_damage_flag[20] = false) and (bike_damage_flag[21] = false) and (bike_damage_flag[22] = false) and (bike_damage_flag[23] = false) and (bike_damage_flag[24] = false) and (bike_damage_flag[25] = false) and (bike_damage_flag[26] = false) and (bike_damage_flag[27] = false) and (bike_damage_flag[28] = false) and (bike_damage_flag[29] = false) and (bike_damage_flag[30] = false) and (bike_damage_flag[31] = false) and (bike_damage_flag[32] = false) and (bike_damage_flag[33] = false) and (bike_damage_flag[34] = false) and (bike_damage_flag[35] = false) and (bike_damage_flag[36] = false) and (bike_damage_flag[37] = false) and (bike_damage_flag[38] = false) and (bike_damage_flag[39] = false) and (bike_damage_flag[40] = false) then writeln('нет') else writeln('есть');
    writeln('   Макс. скорость: ', max_spd);
    writeln('   Средняя скорость: ', avg_spd);writeln;
    writeln;
    writeln('   Остальные параметры');
    writeln(' Текущий город: ', town_name[current_town]);
    writeln(' Деньги: ', money);
    writeln(' Уровень мастерства трюков: ', truck_master * 100, '%');
    writeln;
    writeln(' (1) Отправиться в другой город');
    writeln(' (2) Ремонтная мастерская');
    writeln(' (3) Магазин велосипедов');
    writeln(' (4) Школа каскадёрства');
    if race_off=false then writeln(' (5) Гоночная арена');
    writeln(' (0) Выйти в меню');
    write(' : ');readln(point_str);
    if (point_str = '0') or (point_str = '1') or (point_str = '2') or (point_str = '3') or (point_str = '4') or (point_str = '5') then begin
      if point_str = '0' then point_int := 0;
      if point_str = '1' then point_int := 1;
      if point_str = '2' then point_int := 2;
      if point_str = '3' then point_int := 3;
      if point_str = '4' then point_int := 4;
      if (point_str = '5') and (race_off=false) then point_int := 5;
      if (point_str = '5') and (race_off=true) then point_int := 999;
      case point_int of
        0: goto save_menu;
        1: goto adventure;
        2: goto repair;
        3: goto bike_shop;
        4: goto truck_school;
        5: goto race;
      end;
      point_off := true;
    end;
  end;
  
  save_p10: current_town := 10;ClrScr;
  if tour[current_town] = false then begin
    writedelay('Хрюпань - очень богатый город. За счёт продаж свинины они имеют огромный деньги.', delayer);writeln;
    tour[current_town] := true;Delay(3000);
    inc(shop_master);
  end;
  point_off := false;point_int := 999;
  while point_off = false do 
  begin
    ClrScr;
    writeln('   Состояние велосипеда ', bike_name);
    write('   Наличие повреждений: ');if (bike_damage_flag[1] = false) and (bike_damage_flag[2] = false) and (bike_damage_flag[3] = false) and (bike_damage_flag[4] = false) and (bike_damage_flag[5] = false) and (bike_damage_flag[6] = false) and (bike_damage_flag[7] = false) and (bike_damage_flag[8] = false) and (bike_damage_flag[9] = false) and (bike_damage_flag[10] = false) and (bike_damage_flag[11] = false) and (bike_damage_flag[12] = false) and (bike_damage_flag[13] = false) and (bike_damage_flag[14] = false) and (bike_damage_flag[15] = false) and (bike_damage_flag[16] = false) and (bike_damage_flag[17] = false) and (bike_damage_flag[18] = false) and (bike_damage_flag[19] = false) and (bike_damage_flag[20] = false) and (bike_damage_flag[21] = false) and (bike_damage_flag[22] = false) and (bike_damage_flag[23] = false) and (bike_damage_flag[24] = false) and (bike_damage_flag[25] = false) and (bike_damage_flag[26] = false) and (bike_damage_flag[27] = false) and (bike_damage_flag[28] = false) and (bike_damage_flag[29] = false) and (bike_damage_flag[30] = false) and (bike_damage_flag[31] = false) and (bike_damage_flag[32] = false) and (bike_damage_flag[33] = false) and (bike_damage_flag[34] = false) and (bike_damage_flag[35] = false) and (bike_damage_flag[36] = false) and (bike_damage_flag[37] = false) and (bike_damage_flag[38] = false) and (bike_damage_flag[39] = false) and (bike_damage_flag[40] = false) then writeln('нет') else writeln('есть');
    writeln('   Макс. скорость: ', max_spd);
    writeln('   Средняя скорость: ', avg_spd);writeln;
    writeln;
    writeln('   Остальные параметры');
    writeln(' Текущий город: ', town_name[current_town]);
    writeln(' Деньги: ', money);
    writeln(' Уровень мастерства трюков: ', truck_master * 100, '%');
    writeln;
    writeln(' (1) Отправиться в другой город');
    writeln(' (2) Ремонтная мастерская');
    writeln(' (0) Выйти в меню');
    write(' : ');readln(point_str);
    if (point_str = '0') or (point_str = '1') or (point_str = '2') then begin
      if point_str = '0' then point_int := 0;
      if point_str = '1' then point_int := 1;
      if point_str = '2' then point_int := 2;
      case point_int of
        0: goto save_menu;
        1: goto adventure;
        2: goto repair;
      end;
      point_off := true;
    end;
  end;
  
  save_p11: current_town := 11;ClrScr;
  if tour[current_town] = false then begin
    writedelay('Конструкторское бюро Танковска знаменито на всю страну.', delayer);writeln;
    tour[current_town] := true;Delay(3000);
    inc(shop_master);
  end;
  point_off := false;point_int := 999;
  while point_off = false do 
  begin
    ClrScr;
    writeln('   Состояние велосипеда ', bike_name);
    write('   Наличие повреждений: ');if (bike_damage_flag[1] = false) and (bike_damage_flag[2] = false) and (bike_damage_flag[3] = false) and (bike_damage_flag[4] = false) and (bike_damage_flag[5] = false) and (bike_damage_flag[6] = false) and (bike_damage_flag[7] = false) and (bike_damage_flag[8] = false) and (bike_damage_flag[9] = false) and (bike_damage_flag[10] = false) and (bike_damage_flag[11] = false) and (bike_damage_flag[12] = false) and (bike_damage_flag[13] = false) and (bike_damage_flag[14] = false) and (bike_damage_flag[15] = false) and (bike_damage_flag[16] = false) and (bike_damage_flag[17] = false) and (bike_damage_flag[18] = false) and (bike_damage_flag[19] = false) and (bike_damage_flag[20] = false) and (bike_damage_flag[21] = false) and (bike_damage_flag[22] = false) and (bike_damage_flag[23] = false) and (bike_damage_flag[24] = false) and (bike_damage_flag[25] = false) and (bike_damage_flag[26] = false) and (bike_damage_flag[27] = false) and (bike_damage_flag[28] = false) and (bike_damage_flag[29] = false) and (bike_damage_flag[30] = false) and (bike_damage_flag[31] = false) and (bike_damage_flag[32] = false) and (bike_damage_flag[33] = false) and (bike_damage_flag[34] = false) and (bike_damage_flag[35] = false) and (bike_damage_flag[36] = false) and (bike_damage_flag[37] = false) and (bike_damage_flag[38] = false) and (bike_damage_flag[39] = false) and (bike_damage_flag[40] = false) then writeln('нет') else writeln('есть');
    writeln('   Макс. скорость: ', max_spd);
    writeln('   Средняя скорость: ', avg_spd);writeln;
    writeln;
    writeln('   Остальные параметры');
    writeln(' Текущий город: ', town_name[current_town]);
    writeln(' Деньги: ', money);
    writeln(' Уровень мастерства трюков: ', truck_master * 100, '%');
    writeln;
    writeln(' (1) Отправиться в другой город');
    writeln(' (2) Ремонтная мастерская');
    writeln(' (0) Выйти в меню');
    write(' : ');readln(point_str);
    if (point_str = '0') or (point_str = '1') or (point_str = '2') then begin
      if point_str = '0' then point_int := 0;
      if point_str = '1' then point_int := 1;
      if point_str = '2' then point_int := 2;
      case point_int of
        0: goto save_menu;
        1: goto adventure;
        2: goto repair;
      end;
      point_off := true;
    end;
  end;
  
  save_p12: current_town := 12;ClrScr;
  if tour[current_town] = false then begin
    writedelay('Рогозино - небольшой городок южнее столицы', delayer);writeln;
    tour[current_town] := true;Delay(3000);
    inc(shop_master);
  end;
  point_off := false;point_int := 999;
  while point_off = false do 
  begin
    ClrScr;
    writeln('   Состояние велосипеда ', bike_name);
    write('   Наличие повреждений: ');if (bike_damage_flag[1] = false) and (bike_damage_flag[2] = false) and (bike_damage_flag[3] = false) and (bike_damage_flag[4] = false) and (bike_damage_flag[5] = false) and (bike_damage_flag[6] = false) and (bike_damage_flag[7] = false) and (bike_damage_flag[8] = false) and (bike_damage_flag[9] = false) and (bike_damage_flag[10] = false) and (bike_damage_flag[11] = false) and (bike_damage_flag[12] = false) and (bike_damage_flag[13] = false) and (bike_damage_flag[14] = false) and (bike_damage_flag[15] = false) and (bike_damage_flag[16] = false) and (bike_damage_flag[17] = false) and (bike_damage_flag[18] = false) and (bike_damage_flag[19] = false) and (bike_damage_flag[20] = false) and (bike_damage_flag[21] = false) and (bike_damage_flag[22] = false) and (bike_damage_flag[23] = false) and (bike_damage_flag[24] = false) and (bike_damage_flag[25] = false) and (bike_damage_flag[26] = false) and (bike_damage_flag[27] = false) and (bike_damage_flag[28] = false) and (bike_damage_flag[29] = false) and (bike_damage_flag[30] = false) and (bike_damage_flag[31] = false) and (bike_damage_flag[32] = false) and (bike_damage_flag[33] = false) and (bike_damage_flag[34] = false) and (bike_damage_flag[35] = false) and (bike_damage_flag[36] = false) and (bike_damage_flag[37] = false) and (bike_damage_flag[38] = false) and (bike_damage_flag[39] = false) and (bike_damage_flag[40] = false) then writeln('нет') else writeln('есть');
    writeln('   Макс. скорость: ', max_spd);
    writeln('   Средняя скорость: ', avg_spd);writeln;
    writeln;
    writeln('   Остальные параметры');
    writeln(' Текущий город: ', town_name[current_town]);
    writeln(' Деньги: ', money);
    writeln(' Уровень мастерства трюков: ', truck_master * 100, '%');
    writeln;
    writeln(' (1) Отправиться в другой город');
    writeln(' (2) Ремонтная мастерская');
    writeln(' (0) Выйти в меню');
    write(' : ');readln(point_str);
    if (point_str = '0') or (point_str = '1') or (point_str = '2') then begin
      if point_str = '0' then point_int := 0;
      if point_str = '1' then point_int := 1;
      if point_str = '2' then point_int := 2;
      case point_int of
        0: goto save_menu;
        1: goto adventure;
        2: goto repair;
      end;
      point_off := true;
    end;
  end;
  
  save_p13: current_town := 13;ClrScr;
  if tour[current_town] = false then begin
    writedelay('Котово. Город, в котором когда-то жил человек-кот. Мерзсоть.', delayer);writeln;
    tour[current_town] := true;Delay(3000);
    inc(shop_master);
  end;
  point_off := false;point_int := 999;
  while point_off = false do 
  begin
    ClrScr;
    writeln('   Состояние велосипеда ', bike_name);
    write('   Наличие повреждений: ');if (bike_damage_flag[1] = false) and (bike_damage_flag[2] = false) and (bike_damage_flag[3] = false) and (bike_damage_flag[4] = false) and (bike_damage_flag[5] = false) and (bike_damage_flag[6] = false) and (bike_damage_flag[7] = false) and (bike_damage_flag[8] = false) and (bike_damage_flag[9] = false) and (bike_damage_flag[10] = false) and (bike_damage_flag[11] = false) and (bike_damage_flag[12] = false) and (bike_damage_flag[13] = false) and (bike_damage_flag[14] = false) and (bike_damage_flag[15] = false) and (bike_damage_flag[16] = false) and (bike_damage_flag[17] = false) and (bike_damage_flag[18] = false) and (bike_damage_flag[19] = false) and (bike_damage_flag[20] = false) and (bike_damage_flag[21] = false) and (bike_damage_flag[22] = false) and (bike_damage_flag[23] = false) and (bike_damage_flag[24] = false) and (bike_damage_flag[25] = false) and (bike_damage_flag[26] = false) and (bike_damage_flag[27] = false) and (bike_damage_flag[28] = false) and (bike_damage_flag[29] = false) and (bike_damage_flag[30] = false) and (bike_damage_flag[31] = false) and (bike_damage_flag[32] = false) and (bike_damage_flag[33] = false) and (bike_damage_flag[34] = false) and (bike_damage_flag[35] = false) and (bike_damage_flag[36] = false) and (bike_damage_flag[37] = false) and (bike_damage_flag[38] = false) and (bike_damage_flag[39] = false) and (bike_damage_flag[40] = false) then writeln('нет') else writeln('есть');
    writeln('   Макс. скорость: ', max_spd);
    writeln('   Средняя скорость: ', avg_spd);writeln;
    writeln;
    writeln('   Остальные параметры');
    writeln(' Текущий город: ', town_name[current_town]);
    writeln(' Деньги: ', money);
    writeln(' Уровень мастерства трюков: ', truck_master * 100, '%');
    writeln;
    writeln(' (1) Отправиться в другой город');
    writeln(' (2) Магазин велосипедов');
    writeln(' (0) Выйти в меню');
    write(' : ');readln(point_str);
    if (point_str = '0') or (point_str = '1') or (point_str = '2') then begin
      if point_str = '0' then point_int := 0;
      if point_str = '1' then point_int := 1;
      if point_str = '2' then point_int := 2;
      case point_int of
        0: goto save_menu;
        1: goto adventure;
        2: goto bike_shop;
      end;
      point_off := true;
    end;
  end;
  
  save_p14: current_town := 14;ClrScr;
  if tour[current_town] = false then begin
    writedelay('Когда-то столицей округа был Иркутск. Но уже много времени прошло с тех времён. Бердянск куда больше принёс пользы', delayer);writeln;
    tour[current_town] := true;Delay(3000);
    inc(shop_master);
  end;
  point_off := false;point_int := 999;
  while point_off = false do 
  begin
    ClrScr;
    writeln('   Состояние велосипеда ', bike_name);
    write('   Наличие повреждений: ');if (bike_damage_flag[1] = false) and (bike_damage_flag[2] = false) and (bike_damage_flag[3] = false) and (bike_damage_flag[4] = false) and (bike_damage_flag[5] = false) and (bike_damage_flag[6] = false) and (bike_damage_flag[7] = false) and (bike_damage_flag[8] = false) and (bike_damage_flag[9] = false) and (bike_damage_flag[10] = false) and (bike_damage_flag[11] = false) and (bike_damage_flag[12] = false) and (bike_damage_flag[13] = false) and (bike_damage_flag[14] = false) and (bike_damage_flag[15] = false) and (bike_damage_flag[16] = false) and (bike_damage_flag[17] = false) and (bike_damage_flag[18] = false) and (bike_damage_flag[19] = false) and (bike_damage_flag[20] = false) and (bike_damage_flag[21] = false) and (bike_damage_flag[22] = false) and (bike_damage_flag[23] = false) and (bike_damage_flag[24] = false) and (bike_damage_flag[25] = false) and (bike_damage_flag[26] = false) and (bike_damage_flag[27] = false) and (bike_damage_flag[28] = false) and (bike_damage_flag[29] = false) and (bike_damage_flag[30] = false) and (bike_damage_flag[31] = false) and (bike_damage_flag[32] = false) and (bike_damage_flag[33] = false) and (bike_damage_flag[34] = false) and (bike_damage_flag[35] = false) and (bike_damage_flag[36] = false) and (bike_damage_flag[37] = false) and (bike_damage_flag[38] = false) and (bike_damage_flag[39] = false) and (bike_damage_flag[40] = false) then writeln('нет') else writeln('есть');
    writeln('   Макс. скорость: ', max_spd);
    writeln('   Средняя скорость: ', avg_spd);writeln;
    writeln;
    writeln('   Остальные параметры');
    writeln(' Текущий город: ', town_name[current_town]);
    writeln(' Деньги: ', money);
    writeln(' Уровень мастерства трюков: ', truck_master * 100, '%');
    writeln;
    writeln(' (1) Отправиться в другой город');
    writeln(' (2) Ремонтная мастерская');
    writeln(' (3) Магазин велосипедов');
    writeln(' (4) Школа каскадёрства');
    writeln(' (0) Выйти в меню');
    write(' : ');readln(point_str);
    if (point_str = '0') or (point_str = '1') or (point_str = '2') or (point_str = '3') or (point_str = '4') then begin
      if point_str = '0' then point_int := 0;
      if point_str = '1' then point_int := 1;
      if point_str = '2' then point_int := 2;
      if point_str = '3' then point_int := 3;
      if point_str = '4' then point_int := 4;
      case point_int of
        0: goto save_menu;
        1: goto adventure;
        2: goto repair;
        3: goto bike_shop;
        4: goto truck_school;
      end;
      point_off := true;
    end;
  end;
  
  save_p15: current_town := 15;ClrScr;
  if tour[current_town] = false then begin
    writedelay('Заречье. Заречье - рыболовный район округа', delayer);writeln;
    tour[current_town] := true;Delay(3000);
    inc(shop_master);
  end;
  point_off := false;point_int := 999;
  while point_off = false do 
  begin
    ClrScr;
    writeln('   Состояние велосипеда ', bike_name);
    write('   Наличие повреждений: ');if (bike_damage_flag[1] = false) and (bike_damage_flag[2] = false) and (bike_damage_flag[3] = false) and (bike_damage_flag[4] = false) and (bike_damage_flag[5] = false) and (bike_damage_flag[6] = false) and (bike_damage_flag[7] = false) and (bike_damage_flag[8] = false) and (bike_damage_flag[9] = false) and (bike_damage_flag[10] = false) and (bike_damage_flag[11] = false) and (bike_damage_flag[12] = false) and (bike_damage_flag[13] = false) and (bike_damage_flag[14] = false) and (bike_damage_flag[15] = false) and (bike_damage_flag[16] = false) and (bike_damage_flag[17] = false) and (bike_damage_flag[18] = false) and (bike_damage_flag[19] = false) and (bike_damage_flag[20] = false) and (bike_damage_flag[21] = false) and (bike_damage_flag[22] = false) and (bike_damage_flag[23] = false) and (bike_damage_flag[24] = false) and (bike_damage_flag[25] = false) and (bike_damage_flag[26] = false) and (bike_damage_flag[27] = false) and (bike_damage_flag[28] = false) and (bike_damage_flag[29] = false) and (bike_damage_flag[30] = false) and (bike_damage_flag[31] = false) and (bike_damage_flag[32] = false) and (bike_damage_flag[33] = false) and (bike_damage_flag[34] = false) and (bike_damage_flag[35] = false) and (bike_damage_flag[36] = false) and (bike_damage_flag[37] = false) and (bike_damage_flag[38] = false) and (bike_damage_flag[39] = false) and (bike_damage_flag[40] = false) then writeln('нет') else writeln('есть');
    writeln('   Макс. скорость: ', max_spd);
    writeln('   Средняя скорость: ', avg_spd);writeln;
    writeln;
    writeln('   Остальные параметры');
    writeln(' Текущий город: ', town_name[current_town]);
    writeln(' Деньги: ', money);
    writeln(' Уровень мастерства трюков: ', truck_master * 100, '%');
    writeln;
    writeln(' (1) Отправиться в другой город');
    writeln(' (2) Каскадёрская арена');
    writeln(' (0) Выйти в меню');
    write(' : ');readln(point_str);
    if (point_str = '0') or (point_str = '1') or (point_str = '2') then begin
      if point_str = '0' then point_int := 0;
      if point_str = '1' then point_int := 1;
      if point_str = '2' then point_int := 2;
      case point_int of
        0: goto save_menu;
        1: goto adventure;
        2: goto trucks;
      end;
      point_off := true;
    end;
  end;
  
  save_p16: current_town := 16;ClrScr;
  if tour[current_town] = false then begin
    writedelay('Макарово - военный город. Единственный район, где производят стрелковое оружие', delayer);writeln;
    tour[current_town] := true;Delay(3000);
    inc(shop_master);
  end;
  point_off := false;point_int := 999;
  while point_off = false do 
  begin
    ClrScr;
    writeln('   Состояние велосипеда ', bike_name);
    write('   Наличие повреждений: ');if (bike_damage_flag[1] = false) and (bike_damage_flag[2] = false) and (bike_damage_flag[3] = false) and (bike_damage_flag[4] = false) and (bike_damage_flag[5] = false) and (bike_damage_flag[6] = false) and (bike_damage_flag[7] = false) and (bike_damage_flag[8] = false) and (bike_damage_flag[9] = false) and (bike_damage_flag[10] = false) and (bike_damage_flag[11] = false) and (bike_damage_flag[12] = false) and (bike_damage_flag[13] = false) and (bike_damage_flag[14] = false) and (bike_damage_flag[15] = false) and (bike_damage_flag[16] = false) and (bike_damage_flag[17] = false) and (bike_damage_flag[18] = false) and (bike_damage_flag[19] = false) and (bike_damage_flag[20] = false) and (bike_damage_flag[21] = false) and (bike_damage_flag[22] = false) and (bike_damage_flag[23] = false) and (bike_damage_flag[24] = false) and (bike_damage_flag[25] = false) and (bike_damage_flag[26] = false) and (bike_damage_flag[27] = false) and (bike_damage_flag[28] = false) and (bike_damage_flag[29] = false) and (bike_damage_flag[30] = false) and (bike_damage_flag[31] = false) and (bike_damage_flag[32] = false) and (bike_damage_flag[33] = false) and (bike_damage_flag[34] = false) and (bike_damage_flag[35] = false) and (bike_damage_flag[36] = false) and (bike_damage_flag[37] = false) and (bike_damage_flag[38] = false) and (bike_damage_flag[39] = false) and (bike_damage_flag[40] = false) then writeln('нет') else writeln('есть');
    writeln('   Макс. скорость: ', max_spd);
    writeln('   Средняя скорость: ', avg_spd);writeln;
    writeln;
    writeln('   Остальные параметры');
    writeln(' Текущий город: ', town_name[current_town]);
    writeln(' Деньги: ', money);
    writeln(' Уровень мастерства трюков: ', truck_master * 100, '%');
    writeln;
    writeln(' (1) Отправиться в другой город');
    writeln(' (2) Ремонтная мастерская');
    writeln(' (0) Выйти в меню');
    write(' : ');readln(point_str);
    if (point_str = '0') or (point_str = '1') or (point_str = '2') then begin
      if point_str = '0' then point_int := 0;
      if point_str = '1' then point_int := 1;
      if point_str = '2' then point_int := 2;
      case point_int of
        0: goto save_menu;
        1: goto adventure;
        2: goto repair;
      end;
      point_off := true;
    end;
  end;
  
  save_p17: current_town := 17;ClrScr;
  if tour[current_town] = false then begin
    writedelay('Северозад - древнейший город округа. Кстати, находится он на юге', delayer);writeln;
    tour[current_town] := true;Delay(3000);
    inc(shop_master);
  end;
  point_off := false;point_int := 999;
  while point_off = false do 
  begin
    ClrScr;
    writeln('   Состояние велосипеда ', bike_name);
    write('   Наличие повреждений: ');if (bike_damage_flag[1] = false) and (bike_damage_flag[2] = false) and (bike_damage_flag[3] = false) and (bike_damage_flag[4] = false) and (bike_damage_flag[5] = false) and (bike_damage_flag[6] = false) and (bike_damage_flag[7] = false) and (bike_damage_flag[8] = false) and (bike_damage_flag[9] = false) and (bike_damage_flag[10] = false) and (bike_damage_flag[11] = false) and (bike_damage_flag[12] = false) and (bike_damage_flag[13] = false) and (bike_damage_flag[14] = false) and (bike_damage_flag[15] = false) and (bike_damage_flag[16] = false) and (bike_damage_flag[17] = false) and (bike_damage_flag[18] = false) and (bike_damage_flag[19] = false) and (bike_damage_flag[20] = false) and (bike_damage_flag[21] = false) and (bike_damage_flag[22] = false) and (bike_damage_flag[23] = false) and (bike_damage_flag[24] = false) and (bike_damage_flag[25] = false) and (bike_damage_flag[26] = false) and (bike_damage_flag[27] = false) and (bike_damage_flag[28] = false) and (bike_damage_flag[29] = false) and (bike_damage_flag[30] = false) and (bike_damage_flag[31] = false) and (bike_damage_flag[32] = false) and (bike_damage_flag[33] = false) and (bike_damage_flag[34] = false) and (bike_damage_flag[35] = false) and (bike_damage_flag[36] = false) and (bike_damage_flag[37] = false) and (bike_damage_flag[38] = false) and (bike_damage_flag[39] = false) and (bike_damage_flag[40] = false) then writeln('нет') else writeln('есть');
    writeln('   Макс. скорость: ', max_spd);
    writeln('   Средняя скорость: ', avg_spd);writeln;
    writeln;
    writeln('   Остальные параметры');
    writeln(' Текущий город: ', town_name[current_town]);
    writeln(' Деньги: ', money);
    writeln(' Уровень мастерства трюков: ', truck_master * 100, '%');
    writeln;
    writeln(' (1) Отправиться в другой город');
    writeln(' (2) Каскадёрская арена');
    writeln(' (0) Выйти в меню');
    write(' : ');readln(point_str);
    if (point_str = '0') or (point_str = '1') or (point_str = '2') then begin
      if point_str = '0' then point_int := 0;
      if point_str = '1' then point_int := 1;
      if point_str = '2' then point_int := 2;
      case point_int of
        0: goto save_menu;
        1: goto adventure;
        2: goto trucks;
      end;
      point_off := true;
    end;
  end;
  
  save_p18: current_town := 18;ClrScr;
  if tour[current_town] = false then begin
    writedelay('Междуречье находится между двух рек', delayer);writeln;
    tour[current_town] := true;Delay(3000);
    inc(shop_master);
  end;
  point_off := false;point_int := 999;
  while point_off = false do 
  begin
    ClrScr;
    writeln('   Состояние велосипеда ', bike_name);
    write('   Наличие повреждений: ');if (bike_damage_flag[1] = false) and (bike_damage_flag[2] = false) and (bike_damage_flag[3] = false) and (bike_damage_flag[4] = false) and (bike_damage_flag[5] = false) and (bike_damage_flag[6] = false) and (bike_damage_flag[7] = false) and (bike_damage_flag[8] = false) and (bike_damage_flag[9] = false) and (bike_damage_flag[10] = false) and (bike_damage_flag[11] = false) and (bike_damage_flag[12] = false) and (bike_damage_flag[13] = false) and (bike_damage_flag[14] = false) and (bike_damage_flag[15] = false) and (bike_damage_flag[16] = false) and (bike_damage_flag[17] = false) and (bike_damage_flag[18] = false) and (bike_damage_flag[19] = false) and (bike_damage_flag[20] = false) and (bike_damage_flag[21] = false) and (bike_damage_flag[22] = false) and (bike_damage_flag[23] = false) and (bike_damage_flag[24] = false) and (bike_damage_flag[25] = false) and (bike_damage_flag[26] = false) and (bike_damage_flag[27] = false) and (bike_damage_flag[28] = false) and (bike_damage_flag[29] = false) and (bike_damage_flag[30] = false) and (bike_damage_flag[31] = false) and (bike_damage_flag[32] = false) and (bike_damage_flag[33] = false) and (bike_damage_flag[34] = false) and (bike_damage_flag[35] = false) and (bike_damage_flag[36] = false) and (bike_damage_flag[37] = false) and (bike_damage_flag[38] = false) and (bike_damage_flag[39] = false) and (bike_damage_flag[40] = false) then writeln('нет') else writeln('есть');
    writeln('   Макс. скорость: ', max_spd);
    writeln('   Средняя скорость: ', avg_spd);writeln;
    writeln;
    writeln('   Остальные параметры');
    writeln(' Текущий город: ', town_name[current_town]);
    writeln(' Деньги: ', money);
    writeln(' Уровень мастерства трюков: ', truck_master * 100, '%');
    writeln;
    writeln(' (1) Отправиться в другой город');
    writeln(' (2) Каскадёрская арена');
    writeln(' (0) Выйти в меню');
    write(' : ');readln(point_str);
    if (point_str = '0') or (point_str = '1') or (point_str = '2') then begin
      if point_str = '0' then point_int := 0;
      if point_str = '1' then point_int := 1;
      if point_str = '2' then point_int := 2;
      case point_int of
        0: goto save_menu;
        1: goto adventure;
        2: goto trucks;
      end;
      point_off := true;
    end;
  end;
  
  save_p19: current_town := 19;ClrScr;
  if tour[current_town] = false then begin
    writedelay('Белоозёрск. Хм-м. А белых озёр-то тут нет.', delayer);writeln;
    tour[current_town] := true;Delay(3000);
    inc(shop_master);
  end;
  point_off := false;point_int := 999;
  while point_off = false do 
  begin
    ClrScr;
    writeln('   Состояние велосипеда ', bike_name);
    write('   Наличие повреждений: ');if (bike_damage_flag[1] = false) and (bike_damage_flag[2] = false) and (bike_damage_flag[3] = false) and (bike_damage_flag[4] = false) and (bike_damage_flag[5] = false) and (bike_damage_flag[6] = false) and (bike_damage_flag[7] = false) and (bike_damage_flag[8] = false) and (bike_damage_flag[9] = false) and (bike_damage_flag[10] = false) and (bike_damage_flag[11] = false) and (bike_damage_flag[12] = false) and (bike_damage_flag[13] = false) and (bike_damage_flag[14] = false) and (bike_damage_flag[15] = false) and (bike_damage_flag[16] = false) and (bike_damage_flag[17] = false) and (bike_damage_flag[18] = false) and (bike_damage_flag[19] = false) and (bike_damage_flag[20] = false) and (bike_damage_flag[21] = false) and (bike_damage_flag[22] = false) and (bike_damage_flag[23] = false) and (bike_damage_flag[24] = false) and (bike_damage_flag[25] = false) and (bike_damage_flag[26] = false) and (bike_damage_flag[27] = false) and (bike_damage_flag[28] = false) and (bike_damage_flag[29] = false) and (bike_damage_flag[30] = false) and (bike_damage_flag[31] = false) and (bike_damage_flag[32] = false) and (bike_damage_flag[33] = false) and (bike_damage_flag[34] = false) and (bike_damage_flag[35] = false) and (bike_damage_flag[36] = false) and (bike_damage_flag[37] = false) and (bike_damage_flag[38] = false) and (bike_damage_flag[39] = false) and (bike_damage_flag[40] = false) then writeln('нет') else writeln('есть');
    writeln('   Макс. скорость: ', max_spd);
    writeln('   Средняя скорость: ', avg_spd);writeln;
    writeln;
    writeln('   Остальные параметры');
    writeln(' Текущий город: ', town_name[current_town]);
    writeln(' Деньги: ', money);
    writeln(' Уровень мастерства трюков: ', truck_master * 100, '%');
    writeln;
    writeln(' (1) Отправиться в другой город');
    writeln(' (2) Ремонтная мастерская');
    writeln(' (0) Выйти в меню');
    write(' : ');readln(point_str);
    if (point_str = '0') or (point_str = '1') or (point_str = '2') then begin
      if point_str = '0' then point_int := 0;
      if point_str = '1' then point_int := 1;
      if point_str = '2' then point_int := 2;
      case point_int of
        0: goto save_menu;
        1: goto adventure;
        2: goto repair;
      end;
      point_off := true;
    end;
  end;
  
  save_p20: current_town := 20;ClrScr;
  if tour[current_town] = false then begin
    writedelay('Обезьянск - город, знаменитый своим цирком.', delayer);writeln;
    tour[current_town] := true;Delay(3000);
    inc(shop_master);
  end;
  point_off := false;point_int := 999;
  while point_off = false do 
  begin
    ClrScr;
    writeln('   Состояние велосипеда ', bike_name);
    write('   Наличие повреждений: ');if (bike_damage_flag[1] = false) and (bike_damage_flag[2] = false) and (bike_damage_flag[3] = false) and (bike_damage_flag[4] = false) and (bike_damage_flag[5] = false) and (bike_damage_flag[6] = false) and (bike_damage_flag[7] = false) and (bike_damage_flag[8] = false) and (bike_damage_flag[9] = false) and (bike_damage_flag[10] = false) and (bike_damage_flag[11] = false) and (bike_damage_flag[12] = false) and (bike_damage_flag[13] = false) and (bike_damage_flag[14] = false) and (bike_damage_flag[15] = false) and (bike_damage_flag[16] = false) and (bike_damage_flag[17] = false) and (bike_damage_flag[18] = false) and (bike_damage_flag[19] = false) and (bike_damage_flag[20] = false) and (bike_damage_flag[21] = false) and (bike_damage_flag[22] = false) and (bike_damage_flag[23] = false) and (bike_damage_flag[24] = false) and (bike_damage_flag[25] = false) and (bike_damage_flag[26] = false) and (bike_damage_flag[27] = false) and (bike_damage_flag[28] = false) and (bike_damage_flag[29] = false) and (bike_damage_flag[30] = false) and (bike_damage_flag[31] = false) and (bike_damage_flag[32] = false) and (bike_damage_flag[33] = false) and (bike_damage_flag[34] = false) and (bike_damage_flag[35] = false) and (bike_damage_flag[36] = false) and (bike_damage_flag[37] = false) and (bike_damage_flag[38] = false) and (bike_damage_flag[39] = false) and (bike_damage_flag[40] = false) then writeln('нет') else writeln('есть');
    writeln('   Макс. скорость: ', max_spd);
    writeln('   Средняя скорость: ', avg_spd);writeln;
    writeln;
    writeln('   Остальные параметры');
    writeln(' Текущий город: ', town_name[current_town]);
    writeln(' Деньги: ', money);
    writeln(' Уровень мастерства трюков: ', truck_master * 100, '%');
    writeln;
    writeln(' (1) Отправиться в другой город');
    writeln(' (2) Каскадёрская арена');
    writeln(' (0) Выйти в меню');
    write(' : ');readln(point_str);
    if (point_str = '0') or (point_str = '1') or (point_str = '2') then begin
      if point_str = '0' then point_int := 0;
      if point_str = '1' then point_int := 1;
      if point_str = '2' then point_int := 2;
      case point_int of
        0: goto save_menu;
        1: goto adventure;
        2: goto trucks;
      end;
      point_off := true;
    end;
  end;
  
end.