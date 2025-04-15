use core::circuit::{
    CircuitElement as CE, CircuitInput as CI, CircuitInputs, CircuitOutputsTrait, EvalCircuitTrait,
    circuit_add, circuit_inverse, circuit_mul, circuit_sub, u384,
};
use garaga::core::circuit::AddInputResultTrait2;
use garaga::definitions::{G1Point, get_BN254_modulus, get_GRUMPKIN_modulus};
use garaga::ec_ops::FunctionFelt;

#[inline(always)]
pub fn run_GRUMPKIN_ZK_HONK_SUMCHECK_SIZE_7_PUB_1_circuit(
    p_public_inputs: Span<u256>,
    p_public_inputs_offset: u384,
    libra_sum: u384,
    sumcheck_univariates_flat: Span<u256>,
    sumcheck_evaluations: Span<u256>,
    libra_evaluation: u384,
    tp_sum_check_u_challenges: Span<u128>,
    tp_gate_challenges: Span<u128>,
    tp_eta_1: u384,
    tp_eta_2: u384,
    tp_eta_3: u384,
    tp_beta: u384,
    tp_gamma: u384,
    tp_base_rlc: u384,
    tp_alphas: Span<u128>,
    tp_libra_challenge: u384,
) -> (u384, u384) {
    // CONSTANT stack
    let in0 = CE::<CI<0>> {}; // 0x1
    let in1 = CE::<CI<1>> {}; // 0x80
    let in2 = CE::<CI<2>> {}; // 0x0
    let in3 = CE::<CI<3>> {}; // 0x9d80
    let in4 = CE::<CI<4>> {}; // 0x30644e72e131a029b85045b68181585d2833e84879b9709143e1f593efffec51
    let in5 = CE::<CI<5>> {}; // 0x5a0
    let in6 = CE::<CI<6>> {}; // 0x30644e72e131a029b85045b68181585d2833e84879b9709143e1f593effffd31
    let in7 = CE::<CI<7>> {}; // 0x240
    let in8 = CE::<CI<8>> {}; // 0x2
    let in9 = CE::<CI<9>> {}; // 0x3
    let in10 = CE::<CI<10>> {}; // 0x4
    let in11 = CE::<CI<11>> {}; // 0x5
    let in12 = CE::<CI<12>> {}; // 0x6
    let in13 = CE::<CI<13>> {}; // 0x7
    let in14 = CE::<CI<14>> {}; // 0x8
    let in15 = CE::<
        CI<15>,
    > {}; // 0x183227397098d014dc2822db40c0ac2e9419f4243cdcb848a1f0fac9f8000000
    let in16 = CE::<CI<16>> {}; // -0x1 % p
    let in17 = CE::<CI<17>> {}; // -0x2 % p
    let in18 = CE::<CI<18>> {}; // -0x3 % p
    let in19 = CE::<CI<19>> {}; // 0x11
    let in20 = CE::<CI<20>> {}; // 0x9
    let in21 = CE::<CI<21>> {}; // 0x100000000000000000
    let in22 = CE::<CI<22>> {}; // 0x4000
    let in23 = CE::<
        CI<23>,
    > {}; // 0x10dc6e9c006ea38b04b1e03b4bd9490c0d03f98929ca1d7fb56821fd19d3b6e7
    let in24 = CE::<CI<24>> {}; // 0xc28145b6a44df3e0149b3d0a30b3bb599df9756d4dd9b84a86b38cfb45a740b
    let in25 = CE::<CI<25>> {}; // 0x544b8338791518b2c7645a50392798b21f75bb60e3596170067d00141cac15
    let in26 = CE::<
        CI<26>,
    > {}; // 0x222c01175718386f2e2e82eb122789e352e105a3b8fa852613bc534433ee428b

    // INPUT stack
    let (in27, in28, in29) = (CE::<CI<27>> {}, CE::<CI<28>> {}, CE::<CI<29>> {});
    let (in30, in31, in32) = (CE::<CI<30>> {}, CE::<CI<31>> {}, CE::<CI<32>> {});
    let (in33, in34, in35) = (CE::<CI<33>> {}, CE::<CI<34>> {}, CE::<CI<35>> {});
    let (in36, in37, in38) = (CE::<CI<36>> {}, CE::<CI<37>> {}, CE::<CI<38>> {});
    let (in39, in40, in41) = (CE::<CI<39>> {}, CE::<CI<40>> {}, CE::<CI<41>> {});
    let (in42, in43, in44) = (CE::<CI<42>> {}, CE::<CI<43>> {}, CE::<CI<44>> {});
    let (in45, in46, in47) = (CE::<CI<45>> {}, CE::<CI<46>> {}, CE::<CI<47>> {});
    let (in48, in49, in50) = (CE::<CI<48>> {}, CE::<CI<49>> {}, CE::<CI<50>> {});
    let (in51, in52, in53) = (CE::<CI<51>> {}, CE::<CI<52>> {}, CE::<CI<53>> {});
    let (in54, in55, in56) = (CE::<CI<54>> {}, CE::<CI<55>> {}, CE::<CI<56>> {});
    let (in57, in58, in59) = (CE::<CI<57>> {}, CE::<CI<58>> {}, CE::<CI<59>> {});
    let (in60, in61, in62) = (CE::<CI<60>> {}, CE::<CI<61>> {}, CE::<CI<62>> {});
    let (in63, in64, in65) = (CE::<CI<63>> {}, CE::<CI<64>> {}, CE::<CI<65>> {});
    let (in66, in67, in68) = (CE::<CI<66>> {}, CE::<CI<67>> {}, CE::<CI<68>> {});
    let (in69, in70, in71) = (CE::<CI<69>> {}, CE::<CI<70>> {}, CE::<CI<71>> {});
    let (in72, in73, in74) = (CE::<CI<72>> {}, CE::<CI<73>> {}, CE::<CI<74>> {});
    let (in75, in76, in77) = (CE::<CI<75>> {}, CE::<CI<76>> {}, CE::<CI<77>> {});
    let (in78, in79, in80) = (CE::<CI<78>> {}, CE::<CI<79>> {}, CE::<CI<80>> {});
    let (in81, in82, in83) = (CE::<CI<81>> {}, CE::<CI<82>> {}, CE::<CI<83>> {});
    let (in84, in85, in86) = (CE::<CI<84>> {}, CE::<CI<85>> {}, CE::<CI<86>> {});
    let (in87, in88, in89) = (CE::<CI<87>> {}, CE::<CI<88>> {}, CE::<CI<89>> {});
    let (in90, in91, in92) = (CE::<CI<90>> {}, CE::<CI<91>> {}, CE::<CI<92>> {});
    let (in93, in94, in95) = (CE::<CI<93>> {}, CE::<CI<94>> {}, CE::<CI<95>> {});
    let (in96, in97, in98) = (CE::<CI<96>> {}, CE::<CI<97>> {}, CE::<CI<98>> {});
    let (in99, in100, in101) = (CE::<CI<99>> {}, CE::<CI<100>> {}, CE::<CI<101>> {});
    let (in102, in103, in104) = (CE::<CI<102>> {}, CE::<CI<103>> {}, CE::<CI<104>> {});
    let (in105, in106, in107) = (CE::<CI<105>> {}, CE::<CI<106>> {}, CE::<CI<107>> {});
    let (in108, in109, in110) = (CE::<CI<108>> {}, CE::<CI<109>> {}, CE::<CI<110>> {});
    let (in111, in112, in113) = (CE::<CI<111>> {}, CE::<CI<112>> {}, CE::<CI<113>> {});
    let (in114, in115, in116) = (CE::<CI<114>> {}, CE::<CI<115>> {}, CE::<CI<116>> {});
    let (in117, in118, in119) = (CE::<CI<117>> {}, CE::<CI<118>> {}, CE::<CI<119>> {});
    let (in120, in121, in122) = (CE::<CI<120>> {}, CE::<CI<121>> {}, CE::<CI<122>> {});
    let (in123, in124, in125) = (CE::<CI<123>> {}, CE::<CI<124>> {}, CE::<CI<125>> {});
    let (in126, in127, in128) = (CE::<CI<126>> {}, CE::<CI<127>> {}, CE::<CI<128>> {});
    let (in129, in130, in131) = (CE::<CI<129>> {}, CE::<CI<130>> {}, CE::<CI<131>> {});
    let (in132, in133, in134) = (CE::<CI<132>> {}, CE::<CI<133>> {}, CE::<CI<134>> {});
    let (in135, in136, in137) = (CE::<CI<135>> {}, CE::<CI<136>> {}, CE::<CI<137>> {});
    let (in138, in139, in140) = (CE::<CI<138>> {}, CE::<CI<139>> {}, CE::<CI<140>> {});
    let (in141, in142, in143) = (CE::<CI<141>> {}, CE::<CI<142>> {}, CE::<CI<143>> {});
    let (in144, in145, in146) = (CE::<CI<144>> {}, CE::<CI<145>> {}, CE::<CI<146>> {});
    let (in147, in148, in149) = (CE::<CI<147>> {}, CE::<CI<148>> {}, CE::<CI<149>> {});
    let (in150, in151, in152) = (CE::<CI<150>> {}, CE::<CI<151>> {}, CE::<CI<152>> {});
    let (in153, in154, in155) = (CE::<CI<153>> {}, CE::<CI<154>> {}, CE::<CI<155>> {});
    let (in156, in157, in158) = (CE::<CI<156>> {}, CE::<CI<157>> {}, CE::<CI<158>> {});
    let (in159, in160, in161) = (CE::<CI<159>> {}, CE::<CI<160>> {}, CE::<CI<161>> {});
    let (in162, in163, in164) = (CE::<CI<162>> {}, CE::<CI<163>> {}, CE::<CI<164>> {});
    let (in165, in166, in167) = (CE::<CI<165>> {}, CE::<CI<166>> {}, CE::<CI<167>> {});
    let (in168, in169, in170) = (CE::<CI<168>> {}, CE::<CI<169>> {}, CE::<CI<170>> {});
    let (in171, in172, in173) = (CE::<CI<171>> {}, CE::<CI<172>> {}, CE::<CI<173>> {});
    let (in174, in175, in176) = (CE::<CI<174>> {}, CE::<CI<175>> {}, CE::<CI<176>> {});
    let (in177, in178, in179) = (CE::<CI<177>> {}, CE::<CI<178>> {}, CE::<CI<179>> {});
    let t0 = circuit_add(in1, in28);
    let t1 = circuit_mul(in151, t0);
    let t2 = circuit_add(in152, t1);
    let t3 = circuit_add(in28, in0);
    let t4 = circuit_mul(in151, t3);
    let t5 = circuit_sub(in152, t4);
    let t6 = circuit_add(t2, in27);
    let t7 = circuit_mul(in0, t6);
    let t8 = circuit_add(t5, in27);
    let t9 = circuit_mul(in0, t8);
    let t10 = circuit_inverse(t9);
    let t11 = circuit_mul(t7, t10);
    let t12 = circuit_mul(in179, in29);
    let t13 = circuit_add(in30, in31);
    let t14 = circuit_sub(t13, t12);
    let t15 = circuit_mul(t14, in153);
    let t16 = circuit_add(in2, t15);
    let t17 = circuit_mul(in153, in153);
    let t18 = circuit_sub(in134, in2);
    let t19 = circuit_mul(in0, t18);
    let t20 = circuit_sub(in134, in2);
    let t21 = circuit_mul(in3, t20);
    let t22 = circuit_inverse(t21);
    let t23 = circuit_mul(in30, t22);
    let t24 = circuit_add(in2, t23);
    let t25 = circuit_sub(in134, in0);
    let t26 = circuit_mul(t19, t25);
    let t27 = circuit_sub(in134, in0);
    let t28 = circuit_mul(in4, t27);
    let t29 = circuit_inverse(t28);
    let t30 = circuit_mul(in31, t29);
    let t31 = circuit_add(t24, t30);
    let t32 = circuit_sub(in134, in8);
    let t33 = circuit_mul(t26, t32);
    let t34 = circuit_sub(in134, in8);
    let t35 = circuit_mul(in5, t34);
    let t36 = circuit_inverse(t35);
    let t37 = circuit_mul(in32, t36);
    let t38 = circuit_add(t31, t37);
    let t39 = circuit_sub(in134, in9);
    let t40 = circuit_mul(t33, t39);
    let t41 = circuit_sub(in134, in9);
    let t42 = circuit_mul(in6, t41);
    let t43 = circuit_inverse(t42);
    let t44 = circuit_mul(in33, t43);
    let t45 = circuit_add(t38, t44);
    let t46 = circuit_sub(in134, in10);
    let t47 = circuit_mul(t40, t46);
    let t48 = circuit_sub(in134, in10);
    let t49 = circuit_mul(in7, t48);
    let t50 = circuit_inverse(t49);
    let t51 = circuit_mul(in34, t50);
    let t52 = circuit_add(t45, t51);
    let t53 = circuit_sub(in134, in11);
    let t54 = circuit_mul(t47, t53);
    let t55 = circuit_sub(in134, in11);
    let t56 = circuit_mul(in6, t55);
    let t57 = circuit_inverse(t56);
    let t58 = circuit_mul(in35, t57);
    let t59 = circuit_add(t52, t58);
    let t60 = circuit_sub(in134, in12);
    let t61 = circuit_mul(t54, t60);
    let t62 = circuit_sub(in134, in12);
    let t63 = circuit_mul(in5, t62);
    let t64 = circuit_inverse(t63);
    let t65 = circuit_mul(in36, t64);
    let t66 = circuit_add(t59, t65);
    let t67 = circuit_sub(in134, in13);
    let t68 = circuit_mul(t61, t67);
    let t69 = circuit_sub(in134, in13);
    let t70 = circuit_mul(in4, t69);
    let t71 = circuit_inverse(t70);
    let t72 = circuit_mul(in37, t71);
    let t73 = circuit_add(t66, t72);
    let t74 = circuit_sub(in134, in14);
    let t75 = circuit_mul(t68, t74);
    let t76 = circuit_sub(in134, in14);
    let t77 = circuit_mul(in3, t76);
    let t78 = circuit_inverse(t77);
    let t79 = circuit_mul(in38, t78);
    let t80 = circuit_add(t73, t79);
    let t81 = circuit_mul(t80, t75);
    let t82 = circuit_sub(in141, in0);
    let t83 = circuit_mul(in134, t82);
    let t84 = circuit_add(in0, t83);
    let t85 = circuit_mul(in0, t84);
    let t86 = circuit_add(in39, in40);
    let t87 = circuit_sub(t86, t81);
    let t88 = circuit_mul(t87, t17);
    let t89 = circuit_add(t16, t88);
    let t90 = circuit_mul(t17, in153);
    let t91 = circuit_sub(in135, in2);
    let t92 = circuit_mul(in0, t91);
    let t93 = circuit_sub(in135, in2);
    let t94 = circuit_mul(in3, t93);
    let t95 = circuit_inverse(t94);
    let t96 = circuit_mul(in39, t95);
    let t97 = circuit_add(in2, t96);
    let t98 = circuit_sub(in135, in0);
    let t99 = circuit_mul(t92, t98);
    let t100 = circuit_sub(in135, in0);
    let t101 = circuit_mul(in4, t100);
    let t102 = circuit_inverse(t101);
    let t103 = circuit_mul(in40, t102);
    let t104 = circuit_add(t97, t103);
    let t105 = circuit_sub(in135, in8);
    let t106 = circuit_mul(t99, t105);
    let t107 = circuit_sub(in135, in8);
    let t108 = circuit_mul(in5, t107);
    let t109 = circuit_inverse(t108);
    let t110 = circuit_mul(in41, t109);
    let t111 = circuit_add(t104, t110);
    let t112 = circuit_sub(in135, in9);
    let t113 = circuit_mul(t106, t112);
    let t114 = circuit_sub(in135, in9);
    let t115 = circuit_mul(in6, t114);
    let t116 = circuit_inverse(t115);
    let t117 = circuit_mul(in42, t116);
    let t118 = circuit_add(t111, t117);
    let t119 = circuit_sub(in135, in10);
    let t120 = circuit_mul(t113, t119);
    let t121 = circuit_sub(in135, in10);
    let t122 = circuit_mul(in7, t121);
    let t123 = circuit_inverse(t122);
    let t124 = circuit_mul(in43, t123);
    let t125 = circuit_add(t118, t124);
    let t126 = circuit_sub(in135, in11);
    let t127 = circuit_mul(t120, t126);
    let t128 = circuit_sub(in135, in11);
    let t129 = circuit_mul(in6, t128);
    let t130 = circuit_inverse(t129);
    let t131 = circuit_mul(in44, t130);
    let t132 = circuit_add(t125, t131);
    let t133 = circuit_sub(in135, in12);
    let t134 = circuit_mul(t127, t133);
    let t135 = circuit_sub(in135, in12);
    let t136 = circuit_mul(in5, t135);
    let t137 = circuit_inverse(t136);
    let t138 = circuit_mul(in45, t137);
    let t139 = circuit_add(t132, t138);
    let t140 = circuit_sub(in135, in13);
    let t141 = circuit_mul(t134, t140);
    let t142 = circuit_sub(in135, in13);
    let t143 = circuit_mul(in4, t142);
    let t144 = circuit_inverse(t143);
    let t145 = circuit_mul(in46, t144);
    let t146 = circuit_add(t139, t145);
    let t147 = circuit_sub(in135, in14);
    let t148 = circuit_mul(t141, t147);
    let t149 = circuit_sub(in135, in14);
    let t150 = circuit_mul(in3, t149);
    let t151 = circuit_inverse(t150);
    let t152 = circuit_mul(in47, t151);
    let t153 = circuit_add(t146, t152);
    let t154 = circuit_mul(t153, t148);
    let t155 = circuit_sub(in142, in0);
    let t156 = circuit_mul(in135, t155);
    let t157 = circuit_add(in0, t156);
    let t158 = circuit_mul(t85, t157);
    let t159 = circuit_add(in48, in49);
    let t160 = circuit_sub(t159, t154);
    let t161 = circuit_mul(t160, t90);
    let t162 = circuit_add(t89, t161);
    let t163 = circuit_mul(t90, in153);
    let t164 = circuit_sub(in136, in2);
    let t165 = circuit_mul(in0, t164);
    let t166 = circuit_sub(in136, in2);
    let t167 = circuit_mul(in3, t166);
    let t168 = circuit_inverse(t167);
    let t169 = circuit_mul(in48, t168);
    let t170 = circuit_add(in2, t169);
    let t171 = circuit_sub(in136, in0);
    let t172 = circuit_mul(t165, t171);
    let t173 = circuit_sub(in136, in0);
    let t174 = circuit_mul(in4, t173);
    let t175 = circuit_inverse(t174);
    let t176 = circuit_mul(in49, t175);
    let t177 = circuit_add(t170, t176);
    let t178 = circuit_sub(in136, in8);
    let t179 = circuit_mul(t172, t178);
    let t180 = circuit_sub(in136, in8);
    let t181 = circuit_mul(in5, t180);
    let t182 = circuit_inverse(t181);
    let t183 = circuit_mul(in50, t182);
    let t184 = circuit_add(t177, t183);
    let t185 = circuit_sub(in136, in9);
    let t186 = circuit_mul(t179, t185);
    let t187 = circuit_sub(in136, in9);
    let t188 = circuit_mul(in6, t187);
    let t189 = circuit_inverse(t188);
    let t190 = circuit_mul(in51, t189);
    let t191 = circuit_add(t184, t190);
    let t192 = circuit_sub(in136, in10);
    let t193 = circuit_mul(t186, t192);
    let t194 = circuit_sub(in136, in10);
    let t195 = circuit_mul(in7, t194);
    let t196 = circuit_inverse(t195);
    let t197 = circuit_mul(in52, t196);
    let t198 = circuit_add(t191, t197);
    let t199 = circuit_sub(in136, in11);
    let t200 = circuit_mul(t193, t199);
    let t201 = circuit_sub(in136, in11);
    let t202 = circuit_mul(in6, t201);
    let t203 = circuit_inverse(t202);
    let t204 = circuit_mul(in53, t203);
    let t205 = circuit_add(t198, t204);
    let t206 = circuit_sub(in136, in12);
    let t207 = circuit_mul(t200, t206);
    let t208 = circuit_sub(in136, in12);
    let t209 = circuit_mul(in5, t208);
    let t210 = circuit_inverse(t209);
    let t211 = circuit_mul(in54, t210);
    let t212 = circuit_add(t205, t211);
    let t213 = circuit_sub(in136, in13);
    let t214 = circuit_mul(t207, t213);
    let t215 = circuit_sub(in136, in13);
    let t216 = circuit_mul(in4, t215);
    let t217 = circuit_inverse(t216);
    let t218 = circuit_mul(in55, t217);
    let t219 = circuit_add(t212, t218);
    let t220 = circuit_sub(in136, in14);
    let t221 = circuit_mul(t214, t220);
    let t222 = circuit_sub(in136, in14);
    let t223 = circuit_mul(in3, t222);
    let t224 = circuit_inverse(t223);
    let t225 = circuit_mul(in56, t224);
    let t226 = circuit_add(t219, t225);
    let t227 = circuit_mul(t226, t221);
    let t228 = circuit_sub(in143, in0);
    let t229 = circuit_mul(in136, t228);
    let t230 = circuit_add(in0, t229);
    let t231 = circuit_mul(t158, t230);
    let t232 = circuit_add(in57, in58);
    let t233 = circuit_sub(t232, t227);
    let t234 = circuit_mul(t233, t163);
    let t235 = circuit_add(t162, t234);
    let t236 = circuit_mul(t163, in153);
    let t237 = circuit_sub(in137, in2);
    let t238 = circuit_mul(in0, t237);
    let t239 = circuit_sub(in137, in2);
    let t240 = circuit_mul(in3, t239);
    let t241 = circuit_inverse(t240);
    let t242 = circuit_mul(in57, t241);
    let t243 = circuit_add(in2, t242);
    let t244 = circuit_sub(in137, in0);
    let t245 = circuit_mul(t238, t244);
    let t246 = circuit_sub(in137, in0);
    let t247 = circuit_mul(in4, t246);
    let t248 = circuit_inverse(t247);
    let t249 = circuit_mul(in58, t248);
    let t250 = circuit_add(t243, t249);
    let t251 = circuit_sub(in137, in8);
    let t252 = circuit_mul(t245, t251);
    let t253 = circuit_sub(in137, in8);
    let t254 = circuit_mul(in5, t253);
    let t255 = circuit_inverse(t254);
    let t256 = circuit_mul(in59, t255);
    let t257 = circuit_add(t250, t256);
    let t258 = circuit_sub(in137, in9);
    let t259 = circuit_mul(t252, t258);
    let t260 = circuit_sub(in137, in9);
    let t261 = circuit_mul(in6, t260);
    let t262 = circuit_inverse(t261);
    let t263 = circuit_mul(in60, t262);
    let t264 = circuit_add(t257, t263);
    let t265 = circuit_sub(in137, in10);
    let t266 = circuit_mul(t259, t265);
    let t267 = circuit_sub(in137, in10);
    let t268 = circuit_mul(in7, t267);
    let t269 = circuit_inverse(t268);
    let t270 = circuit_mul(in61, t269);
    let t271 = circuit_add(t264, t270);
    let t272 = circuit_sub(in137, in11);
    let t273 = circuit_mul(t266, t272);
    let t274 = circuit_sub(in137, in11);
    let t275 = circuit_mul(in6, t274);
    let t276 = circuit_inverse(t275);
    let t277 = circuit_mul(in62, t276);
    let t278 = circuit_add(t271, t277);
    let t279 = circuit_sub(in137, in12);
    let t280 = circuit_mul(t273, t279);
    let t281 = circuit_sub(in137, in12);
    let t282 = circuit_mul(in5, t281);
    let t283 = circuit_inverse(t282);
    let t284 = circuit_mul(in63, t283);
    let t285 = circuit_add(t278, t284);
    let t286 = circuit_sub(in137, in13);
    let t287 = circuit_mul(t280, t286);
    let t288 = circuit_sub(in137, in13);
    let t289 = circuit_mul(in4, t288);
    let t290 = circuit_inverse(t289);
    let t291 = circuit_mul(in64, t290);
    let t292 = circuit_add(t285, t291);
    let t293 = circuit_sub(in137, in14);
    let t294 = circuit_mul(t287, t293);
    let t295 = circuit_sub(in137, in14);
    let t296 = circuit_mul(in3, t295);
    let t297 = circuit_inverse(t296);
    let t298 = circuit_mul(in65, t297);
    let t299 = circuit_add(t292, t298);
    let t300 = circuit_mul(t299, t294);
    let t301 = circuit_sub(in144, in0);
    let t302 = circuit_mul(in137, t301);
    let t303 = circuit_add(in0, t302);
    let t304 = circuit_mul(t231, t303);
    let t305 = circuit_add(in66, in67);
    let t306 = circuit_sub(t305, t300);
    let t307 = circuit_mul(t306, t236);
    let t308 = circuit_add(t235, t307);
    let t309 = circuit_mul(t236, in153);
    let t310 = circuit_sub(in138, in2);
    let t311 = circuit_mul(in0, t310);
    let t312 = circuit_sub(in138, in2);
    let t313 = circuit_mul(in3, t312);
    let t314 = circuit_inverse(t313);
    let t315 = circuit_mul(in66, t314);
    let t316 = circuit_add(in2, t315);
    let t317 = circuit_sub(in138, in0);
    let t318 = circuit_mul(t311, t317);
    let t319 = circuit_sub(in138, in0);
    let t320 = circuit_mul(in4, t319);
    let t321 = circuit_inverse(t320);
    let t322 = circuit_mul(in67, t321);
    let t323 = circuit_add(t316, t322);
    let t324 = circuit_sub(in138, in8);
    let t325 = circuit_mul(t318, t324);
    let t326 = circuit_sub(in138, in8);
    let t327 = circuit_mul(in5, t326);
    let t328 = circuit_inverse(t327);
    let t329 = circuit_mul(in68, t328);
    let t330 = circuit_add(t323, t329);
    let t331 = circuit_sub(in138, in9);
    let t332 = circuit_mul(t325, t331);
    let t333 = circuit_sub(in138, in9);
    let t334 = circuit_mul(in6, t333);
    let t335 = circuit_inverse(t334);
    let t336 = circuit_mul(in69, t335);
    let t337 = circuit_add(t330, t336);
    let t338 = circuit_sub(in138, in10);
    let t339 = circuit_mul(t332, t338);
    let t340 = circuit_sub(in138, in10);
    let t341 = circuit_mul(in7, t340);
    let t342 = circuit_inverse(t341);
    let t343 = circuit_mul(in70, t342);
    let t344 = circuit_add(t337, t343);
    let t345 = circuit_sub(in138, in11);
    let t346 = circuit_mul(t339, t345);
    let t347 = circuit_sub(in138, in11);
    let t348 = circuit_mul(in6, t347);
    let t349 = circuit_inverse(t348);
    let t350 = circuit_mul(in71, t349);
    let t351 = circuit_add(t344, t350);
    let t352 = circuit_sub(in138, in12);
    let t353 = circuit_mul(t346, t352);
    let t354 = circuit_sub(in138, in12);
    let t355 = circuit_mul(in5, t354);
    let t356 = circuit_inverse(t355);
    let t357 = circuit_mul(in72, t356);
    let t358 = circuit_add(t351, t357);
    let t359 = circuit_sub(in138, in13);
    let t360 = circuit_mul(t353, t359);
    let t361 = circuit_sub(in138, in13);
    let t362 = circuit_mul(in4, t361);
    let t363 = circuit_inverse(t362);
    let t364 = circuit_mul(in73, t363);
    let t365 = circuit_add(t358, t364);
    let t366 = circuit_sub(in138, in14);
    let t367 = circuit_mul(t360, t366);
    let t368 = circuit_sub(in138, in14);
    let t369 = circuit_mul(in3, t368);
    let t370 = circuit_inverse(t369);
    let t371 = circuit_mul(in74, t370);
    let t372 = circuit_add(t365, t371);
    let t373 = circuit_mul(t372, t367);
    let t374 = circuit_sub(in145, in0);
    let t375 = circuit_mul(in138, t374);
    let t376 = circuit_add(in0, t375);
    let t377 = circuit_mul(t304, t376);
    let t378 = circuit_add(in75, in76);
    let t379 = circuit_sub(t378, t373);
    let t380 = circuit_mul(t379, t309);
    let t381 = circuit_add(t308, t380);
    let t382 = circuit_mul(t309, in153);
    let t383 = circuit_sub(in139, in2);
    let t384 = circuit_mul(in0, t383);
    let t385 = circuit_sub(in139, in2);
    let t386 = circuit_mul(in3, t385);
    let t387 = circuit_inverse(t386);
    let t388 = circuit_mul(in75, t387);
    let t389 = circuit_add(in2, t388);
    let t390 = circuit_sub(in139, in0);
    let t391 = circuit_mul(t384, t390);
    let t392 = circuit_sub(in139, in0);
    let t393 = circuit_mul(in4, t392);
    let t394 = circuit_inverse(t393);
    let t395 = circuit_mul(in76, t394);
    let t396 = circuit_add(t389, t395);
    let t397 = circuit_sub(in139, in8);
    let t398 = circuit_mul(t391, t397);
    let t399 = circuit_sub(in139, in8);
    let t400 = circuit_mul(in5, t399);
    let t401 = circuit_inverse(t400);
    let t402 = circuit_mul(in77, t401);
    let t403 = circuit_add(t396, t402);
    let t404 = circuit_sub(in139, in9);
    let t405 = circuit_mul(t398, t404);
    let t406 = circuit_sub(in139, in9);
    let t407 = circuit_mul(in6, t406);
    let t408 = circuit_inverse(t407);
    let t409 = circuit_mul(in78, t408);
    let t410 = circuit_add(t403, t409);
    let t411 = circuit_sub(in139, in10);
    let t412 = circuit_mul(t405, t411);
    let t413 = circuit_sub(in139, in10);
    let t414 = circuit_mul(in7, t413);
    let t415 = circuit_inverse(t414);
    let t416 = circuit_mul(in79, t415);
    let t417 = circuit_add(t410, t416);
    let t418 = circuit_sub(in139, in11);
    let t419 = circuit_mul(t412, t418);
    let t420 = circuit_sub(in139, in11);
    let t421 = circuit_mul(in6, t420);
    let t422 = circuit_inverse(t421);
    let t423 = circuit_mul(in80, t422);
    let t424 = circuit_add(t417, t423);
    let t425 = circuit_sub(in139, in12);
    let t426 = circuit_mul(t419, t425);
    let t427 = circuit_sub(in139, in12);
    let t428 = circuit_mul(in5, t427);
    let t429 = circuit_inverse(t428);
    let t430 = circuit_mul(in81, t429);
    let t431 = circuit_add(t424, t430);
    let t432 = circuit_sub(in139, in13);
    let t433 = circuit_mul(t426, t432);
    let t434 = circuit_sub(in139, in13);
    let t435 = circuit_mul(in4, t434);
    let t436 = circuit_inverse(t435);
    let t437 = circuit_mul(in82, t436);
    let t438 = circuit_add(t431, t437);
    let t439 = circuit_sub(in139, in14);
    let t440 = circuit_mul(t433, t439);
    let t441 = circuit_sub(in139, in14);
    let t442 = circuit_mul(in3, t441);
    let t443 = circuit_inverse(t442);
    let t444 = circuit_mul(in83, t443);
    let t445 = circuit_add(t438, t444);
    let t446 = circuit_mul(t445, t440);
    let t447 = circuit_sub(in146, in0);
    let t448 = circuit_mul(in139, t447);
    let t449 = circuit_add(in0, t448);
    let t450 = circuit_mul(t377, t449);
    let t451 = circuit_add(in84, in85);
    let t452 = circuit_sub(t451, t446);
    let t453 = circuit_mul(t452, t382);
    let t454 = circuit_add(t381, t453);
    let t455 = circuit_sub(in140, in2);
    let t456 = circuit_mul(in0, t455);
    let t457 = circuit_sub(in140, in2);
    let t458 = circuit_mul(in3, t457);
    let t459 = circuit_inverse(t458);
    let t460 = circuit_mul(in84, t459);
    let t461 = circuit_add(in2, t460);
    let t462 = circuit_sub(in140, in0);
    let t463 = circuit_mul(t456, t462);
    let t464 = circuit_sub(in140, in0);
    let t465 = circuit_mul(in4, t464);
    let t466 = circuit_inverse(t465);
    let t467 = circuit_mul(in85, t466);
    let t468 = circuit_add(t461, t467);
    let t469 = circuit_sub(in140, in8);
    let t470 = circuit_mul(t463, t469);
    let t471 = circuit_sub(in140, in8);
    let t472 = circuit_mul(in5, t471);
    let t473 = circuit_inverse(t472);
    let t474 = circuit_mul(in86, t473);
    let t475 = circuit_add(t468, t474);
    let t476 = circuit_sub(in140, in9);
    let t477 = circuit_mul(t470, t476);
    let t478 = circuit_sub(in140, in9);
    let t479 = circuit_mul(in6, t478);
    let t480 = circuit_inverse(t479);
    let t481 = circuit_mul(in87, t480);
    let t482 = circuit_add(t475, t481);
    let t483 = circuit_sub(in140, in10);
    let t484 = circuit_mul(t477, t483);
    let t485 = circuit_sub(in140, in10);
    let t486 = circuit_mul(in7, t485);
    let t487 = circuit_inverse(t486);
    let t488 = circuit_mul(in88, t487);
    let t489 = circuit_add(t482, t488);
    let t490 = circuit_sub(in140, in11);
    let t491 = circuit_mul(t484, t490);
    let t492 = circuit_sub(in140, in11);
    let t493 = circuit_mul(in6, t492);
    let t494 = circuit_inverse(t493);
    let t495 = circuit_mul(in89, t494);
    let t496 = circuit_add(t489, t495);
    let t497 = circuit_sub(in140, in12);
    let t498 = circuit_mul(t491, t497);
    let t499 = circuit_sub(in140, in12);
    let t500 = circuit_mul(in5, t499);
    let t501 = circuit_inverse(t500);
    let t502 = circuit_mul(in90, t501);
    let t503 = circuit_add(t496, t502);
    let t504 = circuit_sub(in140, in13);
    let t505 = circuit_mul(t498, t504);
    let t506 = circuit_sub(in140, in13);
    let t507 = circuit_mul(in4, t506);
    let t508 = circuit_inverse(t507);
    let t509 = circuit_mul(in91, t508);
    let t510 = circuit_add(t503, t509);
    let t511 = circuit_sub(in140, in14);
    let t512 = circuit_mul(t505, t511);
    let t513 = circuit_sub(in140, in14);
    let t514 = circuit_mul(in3, t513);
    let t515 = circuit_inverse(t514);
    let t516 = circuit_mul(in92, t515);
    let t517 = circuit_add(t510, t516);
    let t518 = circuit_mul(t517, t512);
    let t519 = circuit_sub(in147, in0);
    let t520 = circuit_mul(in140, t519);
    let t521 = circuit_add(in0, t520);
    let t522 = circuit_mul(t450, t521);
    let t523 = circuit_sub(in100, in9);
    let t524 = circuit_mul(t523, in93);
    let t525 = circuit_mul(t524, in121);
    let t526 = circuit_mul(t525, in120);
    let t527 = circuit_mul(t526, in15);
    let t528 = circuit_mul(in95, in120);
    let t529 = circuit_mul(in96, in121);
    let t530 = circuit_mul(in97, in122);
    let t531 = circuit_mul(in98, in123);
    let t532 = circuit_add(t527, t528);
    let t533 = circuit_add(t532, t529);
    let t534 = circuit_add(t533, t530);
    let t535 = circuit_add(t534, t531);
    let t536 = circuit_add(t535, in94);
    let t537 = circuit_sub(in100, in0);
    let t538 = circuit_mul(t537, in131);
    let t539 = circuit_add(t536, t538);
    let t540 = circuit_mul(t539, in100);
    let t541 = circuit_mul(t540, t522);
    let t542 = circuit_add(in120, in123);
    let t543 = circuit_add(t542, in93);
    let t544 = circuit_sub(t543, in128);
    let t545 = circuit_sub(in100, in8);
    let t546 = circuit_mul(t544, t545);
    let t547 = circuit_sub(in100, in0);
    let t548 = circuit_mul(t546, t547);
    let t549 = circuit_mul(t548, in100);
    let t550 = circuit_mul(t549, t522);
    let t551 = circuit_mul(in110, in151);
    let t552 = circuit_add(in120, t551);
    let t553 = circuit_add(t552, in152);
    let t554 = circuit_mul(in111, in151);
    let t555 = circuit_add(in121, t554);
    let t556 = circuit_add(t555, in152);
    let t557 = circuit_mul(t553, t556);
    let t558 = circuit_mul(in112, in151);
    let t559 = circuit_add(in122, t558);
    let t560 = circuit_add(t559, in152);
    let t561 = circuit_mul(t557, t560);
    let t562 = circuit_mul(in113, in151);
    let t563 = circuit_add(in123, t562);
    let t564 = circuit_add(t563, in152);
    let t565 = circuit_mul(t561, t564);
    let t566 = circuit_mul(in106, in151);
    let t567 = circuit_add(in120, t566);
    let t568 = circuit_add(t567, in152);
    let t569 = circuit_mul(in107, in151);
    let t570 = circuit_add(in121, t569);
    let t571 = circuit_add(t570, in152);
    let t572 = circuit_mul(t568, t571);
    let t573 = circuit_mul(in108, in151);
    let t574 = circuit_add(in122, t573);
    let t575 = circuit_add(t574, in152);
    let t576 = circuit_mul(t572, t575);
    let t577 = circuit_mul(in109, in151);
    let t578 = circuit_add(in123, t577);
    let t579 = circuit_add(t578, in152);
    let t580 = circuit_mul(t576, t579);
    let t581 = circuit_add(in124, in118);
    let t582 = circuit_mul(t565, t581);
    let t583 = circuit_mul(in119, t11);
    let t584 = circuit_add(in132, t583);
    let t585 = circuit_mul(t580, t584);
    let t586 = circuit_sub(t582, t585);
    let t587 = circuit_mul(t586, t522);
    let t588 = circuit_mul(in119, in132);
    let t589 = circuit_mul(t588, t522);
    let t590 = circuit_mul(in115, in148);
    let t591 = circuit_mul(in116, in149);
    let t592 = circuit_mul(in117, in150);
    let t593 = circuit_add(in114, in152);
    let t594 = circuit_add(t593, t590);
    let t595 = circuit_add(t594, t591);
    let t596 = circuit_add(t595, t592);
    let t597 = circuit_mul(in96, in128);
    let t598 = circuit_add(in120, in152);
    let t599 = circuit_add(t598, t597);
    let t600 = circuit_mul(in93, in129);
    let t601 = circuit_add(in121, t600);
    let t602 = circuit_mul(in94, in130);
    let t603 = circuit_add(in122, t602);
    let t604 = circuit_mul(t601, in148);
    let t605 = circuit_mul(t603, in149);
    let t606 = circuit_mul(in97, in150);
    let t607 = circuit_add(t599, t604);
    let t608 = circuit_add(t607, t605);
    let t609 = circuit_add(t608, t606);
    let t610 = circuit_mul(in125, t596);
    let t611 = circuit_mul(in125, t609);
    let t612 = circuit_add(in127, in99);
    let t613 = circuit_mul(in127, in99);
    let t614 = circuit_sub(t612, t613);
    let t615 = circuit_mul(t609, t596);
    let t616 = circuit_mul(t615, in125);
    let t617 = circuit_sub(t616, t614);
    let t618 = circuit_mul(t617, t522);
    let t619 = circuit_mul(in99, t610);
    let t620 = circuit_mul(in126, t611);
    let t621 = circuit_sub(t619, t620);
    let t622 = circuit_sub(in121, in120);
    let t623 = circuit_sub(in122, in121);
    let t624 = circuit_sub(in123, in122);
    let t625 = circuit_sub(in128, in123);
    let t626 = circuit_add(t622, in16);
    let t627 = circuit_add(t622, in17);
    let t628 = circuit_add(t622, in18);
    let t629 = circuit_mul(t622, t626);
    let t630 = circuit_mul(t629, t627);
    let t631 = circuit_mul(t630, t628);
    let t632 = circuit_mul(t631, in101);
    let t633 = circuit_mul(t632, t522);
    let t634 = circuit_add(t623, in16);
    let t635 = circuit_add(t623, in17);
    let t636 = circuit_add(t623, in18);
    let t637 = circuit_mul(t623, t634);
    let t638 = circuit_mul(t637, t635);
    let t639 = circuit_mul(t638, t636);
    let t640 = circuit_mul(t639, in101);
    let t641 = circuit_mul(t640, t522);
    let t642 = circuit_add(t624, in16);
    let t643 = circuit_add(t624, in17);
    let t644 = circuit_add(t624, in18);
    let t645 = circuit_mul(t624, t642);
    let t646 = circuit_mul(t645, t643);
    let t647 = circuit_mul(t646, t644);
    let t648 = circuit_mul(t647, in101);
    let t649 = circuit_mul(t648, t522);
    let t650 = circuit_add(t625, in16);
    let t651 = circuit_add(t625, in17);
    let t652 = circuit_add(t625, in18);
    let t653 = circuit_mul(t625, t650);
    let t654 = circuit_mul(t653, t651);
    let t655 = circuit_mul(t654, t652);
    let t656 = circuit_mul(t655, in101);
    let t657 = circuit_mul(t656, t522);
    let t658 = circuit_sub(in128, in121);
    let t659 = circuit_mul(in122, in122);
    let t660 = circuit_mul(in131, in131);
    let t661 = circuit_mul(in122, in131);
    let t662 = circuit_mul(t661, in95);
    let t663 = circuit_add(in129, in128);
    let t664 = circuit_add(t663, in121);
    let t665 = circuit_mul(t664, t658);
    let t666 = circuit_mul(t665, t658);
    let t667 = circuit_sub(t666, t660);
    let t668 = circuit_sub(t667, t659);
    let t669 = circuit_add(t668, t662);
    let t670 = circuit_add(t669, t662);
    let t671 = circuit_sub(in0, in93);
    let t672 = circuit_mul(t670, t522);
    let t673 = circuit_mul(t672, in102);
    let t674 = circuit_mul(t673, t671);
    let t675 = circuit_add(in122, in130);
    let t676 = circuit_mul(in131, in95);
    let t677 = circuit_sub(t676, in122);
    let t678 = circuit_mul(t675, t658);
    let t679 = circuit_sub(in129, in121);
    let t680 = circuit_mul(t679, t677);
    let t681 = circuit_add(t678, t680);
    let t682 = circuit_mul(t681, t522);
    let t683 = circuit_mul(t682, in102);
    let t684 = circuit_mul(t683, t671);
    let t685 = circuit_add(t659, in19);
    let t686 = circuit_mul(t685, in121);
    let t687 = circuit_add(t659, t659);
    let t688 = circuit_add(t687, t687);
    let t689 = circuit_mul(t686, in20);
    let t690 = circuit_add(in129, in121);
    let t691 = circuit_add(t690, in121);
    let t692 = circuit_mul(t691, t688);
    let t693 = circuit_sub(t692, t689);
    let t694 = circuit_mul(t693, t522);
    let t695 = circuit_mul(t694, in102);
    let t696 = circuit_mul(t695, in93);
    let t697 = circuit_add(t674, t696);
    let t698 = circuit_add(in121, in121);
    let t699 = circuit_add(t698, in121);
    let t700 = circuit_mul(t699, in121);
    let t701 = circuit_sub(in121, in129);
    let t702 = circuit_mul(t700, t701);
    let t703 = circuit_add(in122, in122);
    let t704 = circuit_add(in122, in130);
    let t705 = circuit_mul(t703, t704);
    let t706 = circuit_sub(t702, t705);
    let t707 = circuit_mul(t706, t522);
    let t708 = circuit_mul(t707, in102);
    let t709 = circuit_mul(t708, in93);
    let t710 = circuit_add(t684, t709);
    let t711 = circuit_mul(in120, in129);
    let t712 = circuit_mul(in128, in121);
    let t713 = circuit_add(t711, t712);
    let t714 = circuit_mul(in120, in123);
    let t715 = circuit_mul(in121, in122);
    let t716 = circuit_add(t714, t715);
    let t717 = circuit_sub(t716, in130);
    let t718 = circuit_mul(t717, in21);
    let t719 = circuit_sub(t718, in131);
    let t720 = circuit_add(t719, t713);
    let t721 = circuit_mul(t720, in98);
    let t722 = circuit_mul(t713, in21);
    let t723 = circuit_mul(in128, in129);
    let t724 = circuit_add(t722, t723);
    let t725 = circuit_add(in122, in123);
    let t726 = circuit_sub(t724, t725);
    let t727 = circuit_mul(t726, in97);
    let t728 = circuit_add(t724, in123);
    let t729 = circuit_add(in130, in131);
    let t730 = circuit_sub(t728, t729);
    let t731 = circuit_mul(t730, in93);
    let t732 = circuit_add(t727, t721);
    let t733 = circuit_add(t732, t731);
    let t734 = circuit_mul(t733, in96);
    let t735 = circuit_mul(in129, in22);
    let t736 = circuit_add(t735, in128);
    let t737 = circuit_mul(t736, in22);
    let t738 = circuit_add(t737, in122);
    let t739 = circuit_mul(t738, in22);
    let t740 = circuit_add(t739, in121);
    let t741 = circuit_mul(t740, in22);
    let t742 = circuit_add(t741, in120);
    let t743 = circuit_sub(t742, in123);
    let t744 = circuit_mul(t743, in98);
    let t745 = circuit_mul(in130, in22);
    let t746 = circuit_add(t745, in129);
    let t747 = circuit_mul(t746, in22);
    let t748 = circuit_add(t747, in128);
    let t749 = circuit_mul(t748, in22);
    let t750 = circuit_add(t749, in123);
    let t751 = circuit_mul(t750, in22);
    let t752 = circuit_add(t751, in122);
    let t753 = circuit_sub(t752, in131);
    let t754 = circuit_mul(t753, in93);
    let t755 = circuit_add(t744, t754);
    let t756 = circuit_mul(t755, in97);
    let t757 = circuit_mul(in122, in150);
    let t758 = circuit_mul(in121, in149);
    let t759 = circuit_mul(in120, in148);
    let t760 = circuit_add(t757, t758);
    let t761 = circuit_add(t760, t759);
    let t762 = circuit_add(t761, in94);
    let t763 = circuit_sub(t762, in123);
    let t764 = circuit_sub(in128, in120);
    let t765 = circuit_sub(in131, in123);
    let t766 = circuit_mul(t764, t764);
    let t767 = circuit_sub(t766, t764);
    let t768 = circuit_sub(in2, t764);
    let t769 = circuit_add(t768, in0);
    let t770 = circuit_mul(t769, t765);
    let t771 = circuit_mul(in95, in96);
    let t772 = circuit_mul(t771, in103);
    let t773 = circuit_mul(t772, t522);
    let t774 = circuit_mul(t770, t773);
    let t775 = circuit_mul(t767, t773);
    let t776 = circuit_mul(t763, t771);
    let t777 = circuit_sub(in123, t762);
    let t778 = circuit_mul(t777, t777);
    let t779 = circuit_sub(t778, t777);
    let t780 = circuit_mul(in130, in150);
    let t781 = circuit_mul(in129, in149);
    let t782 = circuit_mul(in128, in148);
    let t783 = circuit_add(t780, t781);
    let t784 = circuit_add(t783, t782);
    let t785 = circuit_sub(in131, t784);
    let t786 = circuit_sub(in130, in122);
    let t787 = circuit_sub(in2, t764);
    let t788 = circuit_add(t787, in0);
    let t789 = circuit_sub(in2, t785);
    let t790 = circuit_add(t789, in0);
    let t791 = circuit_mul(t786, t790);
    let t792 = circuit_mul(t788, t791);
    let t793 = circuit_mul(t785, t785);
    let t794 = circuit_sub(t793, t785);
    let t795 = circuit_mul(in100, in103);
    let t796 = circuit_mul(t795, t522);
    let t797 = circuit_mul(t792, t796);
    let t798 = circuit_mul(t767, t796);
    let t799 = circuit_mul(t794, t796);
    let t800 = circuit_mul(t779, in100);
    let t801 = circuit_sub(in129, in121);
    let t802 = circuit_sub(in2, t764);
    let t803 = circuit_add(t802, in0);
    let t804 = circuit_mul(t803, t801);
    let t805 = circuit_sub(t804, in122);
    let t806 = circuit_mul(t805, in98);
    let t807 = circuit_mul(t806, in95);
    let t808 = circuit_add(t776, t807);
    let t809 = circuit_mul(t763, in93);
    let t810 = circuit_mul(t809, in95);
    let t811 = circuit_add(t808, t810);
    let t812 = circuit_add(t811, t800);
    let t813 = circuit_add(t812, t734);
    let t814 = circuit_add(t813, t756);
    let t815 = circuit_mul(t814, in103);
    let t816 = circuit_mul(t815, t522);
    let t817 = circuit_add(in120, in95);
    let t818 = circuit_add(in121, in96);
    let t819 = circuit_add(in122, in97);
    let t820 = circuit_add(in123, in98);
    let t821 = circuit_mul(t817, t817);
    let t822 = circuit_mul(t821, t821);
    let t823 = circuit_mul(t822, t817);
    let t824 = circuit_mul(t818, t818);
    let t825 = circuit_mul(t824, t824);
    let t826 = circuit_mul(t825, t818);
    let t827 = circuit_mul(t819, t819);
    let t828 = circuit_mul(t827, t827);
    let t829 = circuit_mul(t828, t819);
    let t830 = circuit_mul(t820, t820);
    let t831 = circuit_mul(t830, t830);
    let t832 = circuit_mul(t831, t820);
    let t833 = circuit_add(t823, t826);
    let t834 = circuit_add(t829, t832);
    let t835 = circuit_add(t826, t826);
    let t836 = circuit_add(t835, t834);
    let t837 = circuit_add(t832, t832);
    let t838 = circuit_add(t837, t833);
    let t839 = circuit_add(t834, t834);
    let t840 = circuit_add(t839, t839);
    let t841 = circuit_add(t840, t838);
    let t842 = circuit_add(t833, t833);
    let t843 = circuit_add(t842, t842);
    let t844 = circuit_add(t843, t836);
    let t845 = circuit_add(t838, t844);
    let t846 = circuit_add(t836, t841);
    let t847 = circuit_mul(in104, t522);
    let t848 = circuit_sub(t845, in128);
    let t849 = circuit_mul(t847, t848);
    let t850 = circuit_sub(t844, in129);
    let t851 = circuit_mul(t847, t850);
    let t852 = circuit_sub(t846, in130);
    let t853 = circuit_mul(t847, t852);
    let t854 = circuit_sub(t841, in131);
    let t855 = circuit_mul(t847, t854);
    let t856 = circuit_add(in120, in95);
    let t857 = circuit_mul(t856, t856);
    let t858 = circuit_mul(t857, t857);
    let t859 = circuit_mul(t858, t856);
    let t860 = circuit_add(t859, in121);
    let t861 = circuit_add(t860, in122);
    let t862 = circuit_add(t861, in123);
    let t863 = circuit_mul(in105, t522);
    let t864 = circuit_mul(t859, in23);
    let t865 = circuit_add(t864, t862);
    let t866 = circuit_sub(t865, in128);
    let t867 = circuit_mul(t863, t866);
    let t868 = circuit_mul(in121, in24);
    let t869 = circuit_add(t868, t862);
    let t870 = circuit_sub(t869, in129);
    let t871 = circuit_mul(t863, t870);
    let t872 = circuit_mul(in122, in25);
    let t873 = circuit_add(t872, t862);
    let t874 = circuit_sub(t873, in130);
    let t875 = circuit_mul(t863, t874);
    let t876 = circuit_mul(in123, in26);
    let t877 = circuit_add(t876, t862);
    let t878 = circuit_sub(t877, in131);
    let t879 = circuit_mul(t863, t878);
    let t880 = circuit_mul(t550, in154);
    let t881 = circuit_add(t541, t880);
    let t882 = circuit_mul(t587, in155);
    let t883 = circuit_add(t881, t882);
    let t884 = circuit_mul(t589, in156);
    let t885 = circuit_add(t883, t884);
    let t886 = circuit_mul(t618, in157);
    let t887 = circuit_add(t885, t886);
    let t888 = circuit_mul(t621, in158);
    let t889 = circuit_add(t887, t888);
    let t890 = circuit_mul(t633, in159);
    let t891 = circuit_add(t889, t890);
    let t892 = circuit_mul(t641, in160);
    let t893 = circuit_add(t891, t892);
    let t894 = circuit_mul(t649, in161);
    let t895 = circuit_add(t893, t894);
    let t896 = circuit_mul(t657, in162);
    let t897 = circuit_add(t895, t896);
    let t898 = circuit_mul(t697, in163);
    let t899 = circuit_add(t897, t898);
    let t900 = circuit_mul(t710, in164);
    let t901 = circuit_add(t899, t900);
    let t902 = circuit_mul(t816, in165);
    let t903 = circuit_add(t901, t902);
    let t904 = circuit_mul(t774, in166);
    let t905 = circuit_add(t903, t904);
    let t906 = circuit_mul(t775, in167);
    let t907 = circuit_add(t905, t906);
    let t908 = circuit_mul(t797, in168);
    let t909 = circuit_add(t907, t908);
    let t910 = circuit_mul(t798, in169);
    let t911 = circuit_add(t909, t910);
    let t912 = circuit_mul(t799, in170);
    let t913 = circuit_add(t911, t912);
    let t914 = circuit_mul(t849, in171);
    let t915 = circuit_add(t913, t914);
    let t916 = circuit_mul(t851, in172);
    let t917 = circuit_add(t915, t916);
    let t918 = circuit_mul(t853, in173);
    let t919 = circuit_add(t917, t918);
    let t920 = circuit_mul(t855, in174);
    let t921 = circuit_add(t919, t920);
    let t922 = circuit_mul(t867, in175);
    let t923 = circuit_add(t921, t922);
    let t924 = circuit_mul(t871, in176);
    let t925 = circuit_add(t923, t924);
    let t926 = circuit_mul(t875, in177);
    let t927 = circuit_add(t925, t926);
    let t928 = circuit_mul(t879, in178);
    let t929 = circuit_add(t927, t928);
    let t930 = circuit_mul(in0, in136);
    let t931 = circuit_mul(t930, in137);
    let t932 = circuit_mul(t931, in138);
    let t933 = circuit_mul(t932, in139);
    let t934 = circuit_mul(t933, in140);
    let t935 = circuit_sub(in0, t934);
    let t936 = circuit_mul(t929, t935);
    let t937 = circuit_mul(in133, in179);
    let t938 = circuit_add(t936, t937);
    let t939 = circuit_sub(t938, t518);

    let modulus = get_GRUMPKIN_modulus(); // GRUMPKIN prime field modulus

    let mut circuit_inputs = (t454, t939).new_inputs();
    // Prefill constants:

    circuit_inputs = circuit_inputs
        .next_span(ZK_HONK_SUMCHECK_SIZE_7_PUB_1_GRUMPKIN_CONSTANTS.span()); // in0 - in26

    // Fill inputs:

    for val in p_public_inputs {
        circuit_inputs = circuit_inputs.next_u256(*val);
    } // in27 - in27

    circuit_inputs = circuit_inputs.next_2(p_public_inputs_offset); // in28
    circuit_inputs = circuit_inputs.next_2(libra_sum); // in29

    for val in sumcheck_univariates_flat {
        circuit_inputs = circuit_inputs.next_u256(*val);
    } // in30 - in92

    for val in sumcheck_evaluations {
        circuit_inputs = circuit_inputs.next_u256(*val);
    } // in93 - in132

    circuit_inputs = circuit_inputs.next_2(libra_evaluation); // in133

    for val in tp_sum_check_u_challenges {
        circuit_inputs = circuit_inputs.next_u128(*val);
    } // in134 - in140

    for val in tp_gate_challenges {
        circuit_inputs = circuit_inputs.next_u128(*val);
    } // in141 - in147

    circuit_inputs = circuit_inputs.next_2(tp_eta_1); // in148
    circuit_inputs = circuit_inputs.next_2(tp_eta_2); // in149
    circuit_inputs = circuit_inputs.next_2(tp_eta_3); // in150
    circuit_inputs = circuit_inputs.next_2(tp_beta); // in151
    circuit_inputs = circuit_inputs.next_2(tp_gamma); // in152
    circuit_inputs = circuit_inputs.next_2(tp_base_rlc); // in153

    for val in tp_alphas {
        circuit_inputs = circuit_inputs.next_u128(*val);
    } // in154 - in178

    circuit_inputs = circuit_inputs.next_2(tp_libra_challenge); // in179

    let outputs = circuit_inputs.done_2().eval(modulus).unwrap();
    let check_rlc: u384 = outputs.get_output(t454);
    let check: u384 = outputs.get_output(t939);
    return (check_rlc, check);
}
const ZK_HONK_SUMCHECK_SIZE_7_PUB_1_GRUMPKIN_CONSTANTS: [u384; 27] = [
    u384 { limb0: 0x1, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
    u384 { limb0: 0x80, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
    u384 { limb0: 0x0, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
    u384 { limb0: 0x9d80, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
    u384 {
        limb0: 0x79b9709143e1f593efffec51,
        limb1: 0xb85045b68181585d2833e848,
        limb2: 0x30644e72e131a029,
        limb3: 0x0,
    },
    u384 { limb0: 0x5a0, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
    u384 {
        limb0: 0x79b9709143e1f593effffd31,
        limb1: 0xb85045b68181585d2833e848,
        limb2: 0x30644e72e131a029,
        limb3: 0x0,
    },
    u384 { limb0: 0x240, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
    u384 { limb0: 0x2, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
    u384 { limb0: 0x3, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
    u384 { limb0: 0x4, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
    u384 { limb0: 0x5, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
    u384 { limb0: 0x6, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
    u384 { limb0: 0x7, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
    u384 { limb0: 0x8, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
    u384 {
        limb0: 0x3cdcb848a1f0fac9f8000000,
        limb1: 0xdc2822db40c0ac2e9419f424,
        limb2: 0x183227397098d014,
        limb3: 0x0,
    },
    u384 {
        limb0: 0x79b9709143e1f593f0000000,
        limb1: 0xb85045b68181585d2833e848,
        limb2: 0x30644e72e131a029,
        limb3: 0x0,
    },
    u384 {
        limb0: 0x79b9709143e1f593efffffff,
        limb1: 0xb85045b68181585d2833e848,
        limb2: 0x30644e72e131a029,
        limb3: 0x0,
    },
    u384 {
        limb0: 0x79b9709143e1f593effffffe,
        limb1: 0xb85045b68181585d2833e848,
        limb2: 0x30644e72e131a029,
        limb3: 0x0,
    },
    u384 { limb0: 0x11, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
    u384 { limb0: 0x9, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
    u384 { limb0: 0x100000000000000000, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
    u384 { limb0: 0x4000, limb1: 0x0, limb2: 0x0, limb3: 0x0 },
    u384 {
        limb0: 0x29ca1d7fb56821fd19d3b6e7,
        limb1: 0x4b1e03b4bd9490c0d03f989,
        limb2: 0x10dc6e9c006ea38b,
        limb3: 0x0,
    },
    u384 {
        limb0: 0xd4dd9b84a86b38cfb45a740b,
        limb1: 0x149b3d0a30b3bb599df9756,
        limb2: 0xc28145b6a44df3e,
        limb3: 0x0,
    },
    u384 {
        limb0: 0x60e3596170067d00141cac15,
        limb1: 0xb2c7645a50392798b21f75bb,
        limb2: 0x544b8338791518,
        limb3: 0x0,
    },
    u384 {
        limb0: 0xb8fa852613bc534433ee428b,
        limb1: 0x2e2e82eb122789e352e105a3,
        limb2: 0x222c01175718386f,
        limb3: 0x0,
    },
];
#[inline(always)]
pub fn run_GRUMPKIN_ZK_HONK_PREP_MSM_SCALARS_SIZE_7_circuit(
    p_sumcheck_evaluations: Span<u256>,
    p_gemini_masking_eval: u384,
    p_gemini_a_evaluations: Span<u256>,
    p_libra_poly_evals: Span<u256>,
    tp_gemini_r: u384,
    tp_rho: u384,
    tp_shplonk_z: u384,
    tp_shplonk_nu: u384,
    tp_sum_check_u_challenges: Span<u128>,
) -> (
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
    u384,
) {
    // CONSTANT stack
    let in0 = CE::<CI<0>> {}; // 0x0
    let in1 = CE::<CI<1>> {}; // 0x1
    let in2 = CE::<CI<2>> {}; // 0x7b0c561a6148404f086204a9f36ffb0617942546750f230c893619174a57a76

    // INPUT stack
    let (in3, in4, in5) = (CE::<CI<3>> {}, CE::<CI<4>> {}, CE::<CI<5>> {});
    let (in6, in7, in8) = (CE::<CI<6>> {}, CE::<CI<7>> {}, CE::<CI<8>> {});
    let (in9, in10, in11) = (CE::<CI<9>> {}, CE::<CI<10>> {}, CE::<CI<11>> {});
    let (in12, in13, in14) = (CE::<CI<12>> {}, CE::<CI<13>> {}, CE::<CI<14>> {});
    let (in15, in16, in17) = (CE::<CI<15>> {}, CE::<CI<16>> {}, CE::<CI<17>> {});
    let (in18, in19, in20) = (CE::<CI<18>> {}, CE::<CI<19>> {}, CE::<CI<20>> {});
    let (in21, in22, in23) = (CE::<CI<21>> {}, CE::<CI<22>> {}, CE::<CI<23>> {});
    let (in24, in25, in26) = (CE::<CI<24>> {}, CE::<CI<25>> {}, CE::<CI<26>> {});
    let (in27, in28, in29) = (CE::<CI<27>> {}, CE::<CI<28>> {}, CE::<CI<29>> {});
    let (in30, in31, in32) = (CE::<CI<30>> {}, CE::<CI<31>> {}, CE::<CI<32>> {});
    let (in33, in34, in35) = (CE::<CI<33>> {}, CE::<CI<34>> {}, CE::<CI<35>> {});
    let (in36, in37, in38) = (CE::<CI<36>> {}, CE::<CI<37>> {}, CE::<CI<38>> {});
    let (in39, in40, in41) = (CE::<CI<39>> {}, CE::<CI<40>> {}, CE::<CI<41>> {});
    let (in42, in43, in44) = (CE::<CI<42>> {}, CE::<CI<43>> {}, CE::<CI<44>> {});
    let (in45, in46, in47) = (CE::<CI<45>> {}, CE::<CI<46>> {}, CE::<CI<47>> {});
    let (in48, in49, in50) = (CE::<CI<48>> {}, CE::<CI<49>> {}, CE::<CI<50>> {});
    let (in51, in52, in53) = (CE::<CI<51>> {}, CE::<CI<52>> {}, CE::<CI<53>> {});
    let (in54, in55, in56) = (CE::<CI<54>> {}, CE::<CI<55>> {}, CE::<CI<56>> {});
    let (in57, in58, in59) = (CE::<CI<57>> {}, CE::<CI<58>> {}, CE::<CI<59>> {});
    let (in60, in61, in62) = (CE::<CI<60>> {}, CE::<CI<61>> {}, CE::<CI<62>> {});
    let (in63, in64, in65) = (CE::<CI<63>> {}, CE::<CI<64>> {}, CE::<CI<65>> {});
    let t0 = circuit_mul(in55, in55);
    let t1 = circuit_mul(t0, t0);
    let t2 = circuit_mul(t1, t1);
    let t3 = circuit_mul(t2, t2);
    let t4 = circuit_mul(t3, t3);
    let t5 = circuit_mul(t4, t4);
    let t6 = circuit_sub(in57, in55);
    let t7 = circuit_inverse(t6);
    let t8 = circuit_add(in57, in55);
    let t9 = circuit_inverse(t8);
    let t10 = circuit_mul(in58, t9);
    let t11 = circuit_add(t7, t10);
    let t12 = circuit_sub(in0, t11);
    let t13 = circuit_inverse(in55);
    let t14 = circuit_mul(in58, t9);
    let t15 = circuit_sub(t7, t14);
    let t16 = circuit_mul(t13, t15);
    let t17 = circuit_sub(in0, t16);
    let t18 = circuit_mul(t12, in56);
    let t19 = circuit_mul(in3, in56);
    let t20 = circuit_add(in43, t19);
    let t21 = circuit_mul(in56, in56);
    let t22 = circuit_mul(t12, t21);
    let t23 = circuit_mul(in4, t21);
    let t24 = circuit_add(t20, t23);
    let t25 = circuit_mul(t21, in56);
    let t26 = circuit_mul(t12, t25);
    let t27 = circuit_mul(in5, t25);
    let t28 = circuit_add(t24, t27);
    let t29 = circuit_mul(t25, in56);
    let t30 = circuit_mul(t12, t29);
    let t31 = circuit_mul(in6, t29);
    let t32 = circuit_add(t28, t31);
    let t33 = circuit_mul(t29, in56);
    let t34 = circuit_mul(t12, t33);
    let t35 = circuit_mul(in7, t33);
    let t36 = circuit_add(t32, t35);
    let t37 = circuit_mul(t33, in56);
    let t38 = circuit_mul(t12, t37);
    let t39 = circuit_mul(in8, t37);
    let t40 = circuit_add(t36, t39);
    let t41 = circuit_mul(t37, in56);
    let t42 = circuit_mul(t12, t41);
    let t43 = circuit_mul(in9, t41);
    let t44 = circuit_add(t40, t43);
    let t45 = circuit_mul(t41, in56);
    let t46 = circuit_mul(t12, t45);
    let t47 = circuit_mul(in10, t45);
    let t48 = circuit_add(t44, t47);
    let t49 = circuit_mul(t45, in56);
    let t50 = circuit_mul(t12, t49);
    let t51 = circuit_mul(in11, t49);
    let t52 = circuit_add(t48, t51);
    let t53 = circuit_mul(t49, in56);
    let t54 = circuit_mul(t12, t53);
    let t55 = circuit_mul(in12, t53);
    let t56 = circuit_add(t52, t55);
    let t57 = circuit_mul(t53, in56);
    let t58 = circuit_mul(t12, t57);
    let t59 = circuit_mul(in13, t57);
    let t60 = circuit_add(t56, t59);
    let t61 = circuit_mul(t57, in56);
    let t62 = circuit_mul(t12, t61);
    let t63 = circuit_mul(in14, t61);
    let t64 = circuit_add(t60, t63);
    let t65 = circuit_mul(t61, in56);
    let t66 = circuit_mul(t12, t65);
    let t67 = circuit_mul(in15, t65);
    let t68 = circuit_add(t64, t67);
    let t69 = circuit_mul(t65, in56);
    let t70 = circuit_mul(t12, t69);
    let t71 = circuit_mul(in16, t69);
    let t72 = circuit_add(t68, t71);
    let t73 = circuit_mul(t69, in56);
    let t74 = circuit_mul(t12, t73);
    let t75 = circuit_mul(in17, t73);
    let t76 = circuit_add(t72, t75);
    let t77 = circuit_mul(t73, in56);
    let t78 = circuit_mul(t12, t77);
    let t79 = circuit_mul(in18, t77);
    let t80 = circuit_add(t76, t79);
    let t81 = circuit_mul(t77, in56);
    let t82 = circuit_mul(t12, t81);
    let t83 = circuit_mul(in19, t81);
    let t84 = circuit_add(t80, t83);
    let t85 = circuit_mul(t81, in56);
    let t86 = circuit_mul(t12, t85);
    let t87 = circuit_mul(in20, t85);
    let t88 = circuit_add(t84, t87);
    let t89 = circuit_mul(t85, in56);
    let t90 = circuit_mul(t12, t89);
    let t91 = circuit_mul(in21, t89);
    let t92 = circuit_add(t88, t91);
    let t93 = circuit_mul(t89, in56);
    let t94 = circuit_mul(t12, t93);
    let t95 = circuit_mul(in22, t93);
    let t96 = circuit_add(t92, t95);
    let t97 = circuit_mul(t93, in56);
    let t98 = circuit_mul(t12, t97);
    let t99 = circuit_mul(in23, t97);
    let t100 = circuit_add(t96, t99);
    let t101 = circuit_mul(t97, in56);
    let t102 = circuit_mul(t12, t101);
    let t103 = circuit_mul(in24, t101);
    let t104 = circuit_add(t100, t103);
    let t105 = circuit_mul(t101, in56);
    let t106 = circuit_mul(t12, t105);
    let t107 = circuit_mul(in25, t105);
    let t108 = circuit_add(t104, t107);
    let t109 = circuit_mul(t105, in56);
    let t110 = circuit_mul(t12, t109);
    let t111 = circuit_mul(in26, t109);
    let t112 = circuit_add(t108, t111);
    let t113 = circuit_mul(t109, in56);
    let t114 = circuit_mul(t12, t113);
    let t115 = circuit_mul(in27, t113);
    let t116 = circuit_add(t112, t115);
    let t117 = circuit_mul(t113, in56);
    let t118 = circuit_mul(t12, t117);
    let t119 = circuit_mul(in28, t117);
    let t120 = circuit_add(t116, t119);
    let t121 = circuit_mul(t117, in56);
    let t122 = circuit_mul(t12, t121);
    let t123 = circuit_mul(in29, t121);
    let t124 = circuit_add(t120, t123);
    let t125 = circuit_mul(t121, in56);
    let t126 = circuit_mul(t12, t125);
    let t127 = circuit_mul(in30, t125);
    let t128 = circuit_add(t124, t127);
    let t129 = circuit_mul(t125, in56);
    let t130 = circuit_mul(t12, t129);
    let t131 = circuit_mul(in31, t129);
    let t132 = circuit_add(t128, t131);
    let t133 = circuit_mul(t129, in56);
    let t134 = circuit_mul(t12, t133);
    let t135 = circuit_mul(in32, t133);
    let t136 = circuit_add(t132, t135);
    let t137 = circuit_mul(t133, in56);
    let t138 = circuit_mul(t12, t137);
    let t139 = circuit_mul(in33, t137);
    let t140 = circuit_add(t136, t139);
    let t141 = circuit_mul(t137, in56);
    let t142 = circuit_mul(t12, t141);
    let t143 = circuit_mul(in34, t141);
    let t144 = circuit_add(t140, t143);
    let t145 = circuit_mul(t141, in56);
    let t146 = circuit_mul(t12, t145);
    let t147 = circuit_mul(in35, t145);
    let t148 = circuit_add(t144, t147);
    let t149 = circuit_mul(t145, in56);
    let t150 = circuit_mul(t12, t149);
    let t151 = circuit_mul(in36, t149);
    let t152 = circuit_add(t148, t151);
    let t153 = circuit_mul(t149, in56);
    let t154 = circuit_mul(t12, t153);
    let t155 = circuit_mul(in37, t153);
    let t156 = circuit_add(t152, t155);
    let t157 = circuit_mul(t153, in56);
    let t158 = circuit_mul(t17, t157);
    let t159 = circuit_mul(in38, t157);
    let t160 = circuit_add(t156, t159);
    let t161 = circuit_mul(t157, in56);
    let t162 = circuit_mul(t17, t161);
    let t163 = circuit_mul(in39, t161);
    let t164 = circuit_add(t160, t163);
    let t165 = circuit_mul(t161, in56);
    let t166 = circuit_mul(t17, t165);
    let t167 = circuit_mul(in40, t165);
    let t168 = circuit_add(t164, t167);
    let t169 = circuit_mul(t165, in56);
    let t170 = circuit_mul(t17, t169);
    let t171 = circuit_mul(in41, t169);
    let t172 = circuit_add(t168, t171);
    let t173 = circuit_mul(t169, in56);
    let t174 = circuit_mul(t17, t173);
    let t175 = circuit_mul(in42, t173);
    let t176 = circuit_add(t172, t175);
    let t177 = circuit_sub(in1, in65);
    let t178 = circuit_mul(t5, t177);
    let t179 = circuit_mul(t5, t176);
    let t180 = circuit_add(t179, t179);
    let t181 = circuit_sub(t178, in65);
    let t182 = circuit_mul(in50, t181);
    let t183 = circuit_sub(t180, t182);
    let t184 = circuit_add(t178, in65);
    let t185 = circuit_inverse(t184);
    let t186 = circuit_mul(t183, t185);
    let t187 = circuit_sub(in1, in64);
    let t188 = circuit_mul(t4, t187);
    let t189 = circuit_mul(t4, t186);
    let t190 = circuit_add(t189, t189);
    let t191 = circuit_sub(t188, in64);
    let t192 = circuit_mul(in49, t191);
    let t193 = circuit_sub(t190, t192);
    let t194 = circuit_add(t188, in64);
    let t195 = circuit_inverse(t194);
    let t196 = circuit_mul(t193, t195);
    let t197 = circuit_sub(in1, in63);
    let t198 = circuit_mul(t3, t197);
    let t199 = circuit_mul(t3, t196);
    let t200 = circuit_add(t199, t199);
    let t201 = circuit_sub(t198, in63);
    let t202 = circuit_mul(in48, t201);
    let t203 = circuit_sub(t200, t202);
    let t204 = circuit_add(t198, in63);
    let t205 = circuit_inverse(t204);
    let t206 = circuit_mul(t203, t205);
    let t207 = circuit_sub(in1, in62);
    let t208 = circuit_mul(t2, t207);
    let t209 = circuit_mul(t2, t206);
    let t210 = circuit_add(t209, t209);
    let t211 = circuit_sub(t208, in62);
    let t212 = circuit_mul(in47, t211);
    let t213 = circuit_sub(t210, t212);
    let t214 = circuit_add(t208, in62);
    let t215 = circuit_inverse(t214);
    let t216 = circuit_mul(t213, t215);
    let t217 = circuit_sub(in1, in61);
    let t218 = circuit_mul(t1, t217);
    let t219 = circuit_mul(t1, t216);
    let t220 = circuit_add(t219, t219);
    let t221 = circuit_sub(t218, in61);
    let t222 = circuit_mul(in46, t221);
    let t223 = circuit_sub(t220, t222);
    let t224 = circuit_add(t218, in61);
    let t225 = circuit_inverse(t224);
    let t226 = circuit_mul(t223, t225);
    let t227 = circuit_sub(in1, in60);
    let t228 = circuit_mul(t0, t227);
    let t229 = circuit_mul(t0, t226);
    let t230 = circuit_add(t229, t229);
    let t231 = circuit_sub(t228, in60);
    let t232 = circuit_mul(in45, t231);
    let t233 = circuit_sub(t230, t232);
    let t234 = circuit_add(t228, in60);
    let t235 = circuit_inverse(t234);
    let t236 = circuit_mul(t233, t235);
    let t237 = circuit_sub(in1, in59);
    let t238 = circuit_mul(in55, t237);
    let t239 = circuit_mul(in55, t236);
    let t240 = circuit_add(t239, t239);
    let t241 = circuit_sub(t238, in59);
    let t242 = circuit_mul(in44, t241);
    let t243 = circuit_sub(t240, t242);
    let t244 = circuit_add(t238, in59);
    let t245 = circuit_inverse(t244);
    let t246 = circuit_mul(t243, t245);
    let t247 = circuit_mul(t246, t7);
    let t248 = circuit_mul(in44, in58);
    let t249 = circuit_mul(t248, t9);
    let t250 = circuit_add(t247, t249);
    let t251 = circuit_mul(in58, in58);
    let t252 = circuit_sub(in57, t0);
    let t253 = circuit_inverse(t252);
    let t254 = circuit_add(in57, t0);
    let t255 = circuit_inverse(t254);
    let t256 = circuit_mul(t251, t253);
    let t257 = circuit_mul(in58, t255);
    let t258 = circuit_mul(t251, t257);
    let t259 = circuit_add(t258, t256);
    let t260 = circuit_sub(in0, t259);
    let t261 = circuit_mul(t258, in45);
    let t262 = circuit_mul(t256, t236);
    let t263 = circuit_add(t261, t262);
    let t264 = circuit_add(t250, t263);
    let t265 = circuit_mul(in58, in58);
    let t266 = circuit_mul(t251, t265);
    let t267 = circuit_sub(in57, t1);
    let t268 = circuit_inverse(t267);
    let t269 = circuit_add(in57, t1);
    let t270 = circuit_inverse(t269);
    let t271 = circuit_mul(t266, t268);
    let t272 = circuit_mul(in58, t270);
    let t273 = circuit_mul(t266, t272);
    let t274 = circuit_add(t273, t271);
    let t275 = circuit_sub(in0, t274);
    let t276 = circuit_mul(t273, in46);
    let t277 = circuit_mul(t271, t226);
    let t278 = circuit_add(t276, t277);
    let t279 = circuit_add(t264, t278);
    let t280 = circuit_mul(in58, in58);
    let t281 = circuit_mul(t266, t280);
    let t282 = circuit_sub(in57, t2);
    let t283 = circuit_inverse(t282);
    let t284 = circuit_add(in57, t2);
    let t285 = circuit_inverse(t284);
    let t286 = circuit_mul(t281, t283);
    let t287 = circuit_mul(in58, t285);
    let t288 = circuit_mul(t281, t287);
    let t289 = circuit_add(t288, t286);
    let t290 = circuit_sub(in0, t289);
    let t291 = circuit_mul(t288, in47);
    let t292 = circuit_mul(t286, t216);
    let t293 = circuit_add(t291, t292);
    let t294 = circuit_add(t279, t293);
    let t295 = circuit_mul(in58, in58);
    let t296 = circuit_mul(t281, t295);
    let t297 = circuit_sub(in57, t3);
    let t298 = circuit_inverse(t297);
    let t299 = circuit_add(in57, t3);
    let t300 = circuit_inverse(t299);
    let t301 = circuit_mul(t296, t298);
    let t302 = circuit_mul(in58, t300);
    let t303 = circuit_mul(t296, t302);
    let t304 = circuit_add(t303, t301);
    let t305 = circuit_sub(in0, t304);
    let t306 = circuit_mul(t303, in48);
    let t307 = circuit_mul(t301, t206);
    let t308 = circuit_add(t306, t307);
    let t309 = circuit_add(t294, t308);
    let t310 = circuit_mul(in58, in58);
    let t311 = circuit_mul(t296, t310);
    let t312 = circuit_sub(in57, t4);
    let t313 = circuit_inverse(t312);
    let t314 = circuit_add(in57, t4);
    let t315 = circuit_inverse(t314);
    let t316 = circuit_mul(t311, t313);
    let t317 = circuit_mul(in58, t315);
    let t318 = circuit_mul(t311, t317);
    let t319 = circuit_add(t318, t316);
    let t320 = circuit_sub(in0, t319);
    let t321 = circuit_mul(t318, in49);
    let t322 = circuit_mul(t316, t196);
    let t323 = circuit_add(t321, t322);
    let t324 = circuit_add(t309, t323);
    let t325 = circuit_mul(in58, in58);
    let t326 = circuit_mul(t311, t325);
    let t327 = circuit_sub(in57, t5);
    let t328 = circuit_inverse(t327);
    let t329 = circuit_add(in57, t5);
    let t330 = circuit_inverse(t329);
    let t331 = circuit_mul(t326, t328);
    let t332 = circuit_mul(in58, t330);
    let t333 = circuit_mul(t326, t332);
    let t334 = circuit_add(t333, t331);
    let t335 = circuit_sub(in0, t334);
    let t336 = circuit_mul(t333, in50);
    let t337 = circuit_mul(t331, t186);
    let t338 = circuit_add(t336, t337);
    let t339 = circuit_add(t324, t338);
    let t340 = circuit_mul(in58, in58);
    let t341 = circuit_mul(t326, t340);
    let t342 = circuit_mul(in58, in58);
    let t343 = circuit_mul(t341, t342);
    let t344 = circuit_mul(in58, in58);
    let t345 = circuit_mul(t343, t344);
    let t346 = circuit_mul(in58, in58);
    let t347 = circuit_mul(t345, t346);
    let t348 = circuit_mul(in58, in58);
    let t349 = circuit_mul(t347, t348);
    let t350 = circuit_mul(in58, in58);
    let t351 = circuit_mul(t349, t350);
    let t352 = circuit_mul(in58, in58);
    let t353 = circuit_mul(t351, t352);
    let t354 = circuit_mul(in58, in58);
    let t355 = circuit_mul(t353, t354);
    let t356 = circuit_mul(in58, in58);
    let t357 = circuit_mul(t355, t356);
    let t358 = circuit_mul(in58, in58);
    let t359 = circuit_mul(t357, t358);
    let t360 = circuit_mul(in58, in58);
    let t361 = circuit_mul(t359, t360);
    let t362 = circuit_mul(in58, in58);
    let t363 = circuit_mul(t361, t362);
    let t364 = circuit_mul(in58, in58);
    let t365 = circuit_mul(t363, t364);
    let t366 = circuit_mul(in58, in58);
    let t367 = circuit_mul(t365, t366);
    let t368 = circuit_mul(in58, in58);
    let t369 = circuit_mul(t367, t368);
    let t370 = circuit_mul(in58, in58);
    let t371 = circuit_mul(t369, t370);
    let t372 = circuit_mul(in58, in58);
    let t373 = circuit_mul(t371, t372);
    let t374 = circuit_mul(in58, in58);
    let t375 = circuit_mul(t373, t374);
    let t376 = circuit_mul(in58, in58);
    let t377 = circuit_mul(t375, t376);
    let t378 = circuit_mul(in58, in58);
    let t379 = circuit_mul(t377, t378);
    let t380 = circuit_mul(in58, in58);
    let t381 = circuit_mul(t379, t380);
    let t382 = circuit_mul(in58, in58);
    let t383 = circuit_mul(t381, t382);
    let t384 = circuit_sub(in57, in55);
    let t385 = circuit_inverse(t384);
    let t386 = circuit_mul(in1, t385);
    let t387 = circuit_mul(in2, in55);
    let t388 = circuit_sub(in57, t387);
    let t389 = circuit_inverse(t388);
    let t390 = circuit_mul(in1, t389);
    let t391 = circuit_mul(in58, in58);
    let t392 = circuit_mul(t383, t391);
    let t393 = circuit_mul(t386, t392);
    let t394 = circuit_sub(in0, t393);
    let t395 = circuit_mul(t392, in58);
    let t396 = circuit_mul(t393, in51);
    let t397 = circuit_add(t339, t396);
    let t398 = circuit_mul(t390, t395);
    let t399 = circuit_sub(in0, t398);
    let t400 = circuit_mul(t395, in58);
    let t401 = circuit_mul(t398, in52);
    let t402 = circuit_add(t397, t401);
    let t403 = circuit_mul(t386, t400);
    let t404 = circuit_sub(in0, t403);
    let t405 = circuit_mul(t400, in58);
    let t406 = circuit_mul(t403, in53);
    let t407 = circuit_add(t402, t406);
    let t408 = circuit_mul(t386, t405);
    let t409 = circuit_sub(in0, t408);
    let t410 = circuit_mul(t408, in54);
    let t411 = circuit_add(t407, t410);
    let t412 = circuit_add(t399, t404);
    let t413 = circuit_add(t126, t158);
    let t414 = circuit_add(t130, t162);
    let t415 = circuit_add(t134, t166);
    let t416 = circuit_add(t138, t170);
    let t417 = circuit_add(t142, t174);

    let modulus = get_GRUMPKIN_modulus(); // GRUMPKIN prime field modulus

    let mut circuit_inputs = (
        t12,
        t18,
        t22,
        t26,
        t30,
        t34,
        t38,
        t42,
        t46,
        t50,
        t54,
        t58,
        t62,
        t66,
        t70,
        t74,
        t78,
        t82,
        t86,
        t90,
        t94,
        t98,
        t102,
        t106,
        t110,
        t114,
        t118,
        t122,
        t413,
        t414,
        t415,
        t416,
        t417,
        t146,
        t150,
        t154,
        t260,
        t275,
        t290,
        t305,
        t320,
        t335,
        t394,
        t412,
        t409,
        t411,
    )
        .new_inputs();
    // Prefill constants:
    circuit_inputs = circuit_inputs.next_2([0x0, 0x0, 0x0, 0x0]); // in0
    circuit_inputs = circuit_inputs.next_2([0x1, 0x0, 0x0, 0x0]); // in1
    circuit_inputs = circuit_inputs
        .next_2(
            [0x6750f230c893619174a57a76, 0xf086204a9f36ffb061794254, 0x7b0c561a6148404, 0x0],
        ); // in2
    // Fill inputs:

    for val in p_sumcheck_evaluations {
        circuit_inputs = circuit_inputs.next_u256(*val);
    } // in3 - in42

    circuit_inputs = circuit_inputs.next_2(p_gemini_masking_eval); // in43

    for val in p_gemini_a_evaluations {
        circuit_inputs = circuit_inputs.next_u256(*val);
    } // in44 - in50

    for val in p_libra_poly_evals {
        circuit_inputs = circuit_inputs.next_u256(*val);
    } // in51 - in54

    circuit_inputs = circuit_inputs.next_2(tp_gemini_r); // in55
    circuit_inputs = circuit_inputs.next_2(tp_rho); // in56
    circuit_inputs = circuit_inputs.next_2(tp_shplonk_z); // in57
    circuit_inputs = circuit_inputs.next_2(tp_shplonk_nu); // in58

    for val in tp_sum_check_u_challenges {
        circuit_inputs = circuit_inputs.next_u128(*val);
    } // in59 - in65

    let outputs = circuit_inputs.done_2().eval(modulus).unwrap();
    let scalar_1: u384 = outputs.get_output(t12);
    let scalar_2: u384 = outputs.get_output(t18);
    let scalar_3: u384 = outputs.get_output(t22);
    let scalar_4: u384 = outputs.get_output(t26);
    let scalar_5: u384 = outputs.get_output(t30);
    let scalar_6: u384 = outputs.get_output(t34);
    let scalar_7: u384 = outputs.get_output(t38);
    let scalar_8: u384 = outputs.get_output(t42);
    let scalar_9: u384 = outputs.get_output(t46);
    let scalar_10: u384 = outputs.get_output(t50);
    let scalar_11: u384 = outputs.get_output(t54);
    let scalar_12: u384 = outputs.get_output(t58);
    let scalar_13: u384 = outputs.get_output(t62);
    let scalar_14: u384 = outputs.get_output(t66);
    let scalar_15: u384 = outputs.get_output(t70);
    let scalar_16: u384 = outputs.get_output(t74);
    let scalar_17: u384 = outputs.get_output(t78);
    let scalar_18: u384 = outputs.get_output(t82);
    let scalar_19: u384 = outputs.get_output(t86);
    let scalar_20: u384 = outputs.get_output(t90);
    let scalar_21: u384 = outputs.get_output(t94);
    let scalar_22: u384 = outputs.get_output(t98);
    let scalar_23: u384 = outputs.get_output(t102);
    let scalar_24: u384 = outputs.get_output(t106);
    let scalar_25: u384 = outputs.get_output(t110);
    let scalar_26: u384 = outputs.get_output(t114);
    let scalar_27: u384 = outputs.get_output(t118);
    let scalar_28: u384 = outputs.get_output(t122);
    let scalar_29: u384 = outputs.get_output(t413);
    let scalar_30: u384 = outputs.get_output(t414);
    let scalar_31: u384 = outputs.get_output(t415);
    let scalar_32: u384 = outputs.get_output(t416);
    let scalar_33: u384 = outputs.get_output(t417);
    let scalar_34: u384 = outputs.get_output(t146);
    let scalar_35: u384 = outputs.get_output(t150);
    let scalar_36: u384 = outputs.get_output(t154);
    let scalar_42: u384 = outputs.get_output(t260);
    let scalar_43: u384 = outputs.get_output(t275);
    let scalar_44: u384 = outputs.get_output(t290);
    let scalar_45: u384 = outputs.get_output(t305);
    let scalar_46: u384 = outputs.get_output(t320);
    let scalar_47: u384 = outputs.get_output(t335);
    let scalar_69: u384 = outputs.get_output(t394);
    let scalar_70: u384 = outputs.get_output(t412);
    let scalar_71: u384 = outputs.get_output(t409);
    let scalar_72: u384 = outputs.get_output(t411);
    return (
        scalar_1,
        scalar_2,
        scalar_3,
        scalar_4,
        scalar_5,
        scalar_6,
        scalar_7,
        scalar_8,
        scalar_9,
        scalar_10,
        scalar_11,
        scalar_12,
        scalar_13,
        scalar_14,
        scalar_15,
        scalar_16,
        scalar_17,
        scalar_18,
        scalar_19,
        scalar_20,
        scalar_21,
        scalar_22,
        scalar_23,
        scalar_24,
        scalar_25,
        scalar_26,
        scalar_27,
        scalar_28,
        scalar_29,
        scalar_30,
        scalar_31,
        scalar_32,
        scalar_33,
        scalar_34,
        scalar_35,
        scalar_36,
        scalar_42,
        scalar_43,
        scalar_44,
        scalar_45,
        scalar_46,
        scalar_47,
        scalar_69,
        scalar_70,
        scalar_71,
        scalar_72,
    );
}
#[inline(always)]
pub fn run_GRUMPKIN_ZK_HONK_EVALS_CONS_INIT_SIZE_7_circuit(tp_gemini_r: u384) -> (u384, u384) {
    // CONSTANT stack
    let in0 = CE::<CI<0>> {}; // 0x1
    let in1 = CE::<CI<1>> {}; // 0x204bd3277422fad364751ad938e2b5e6a54cf8c68712848a692c553d0329f5d6

    // INPUT stack
    let in2 = CE::<CI<2>> {};
    let t0 = circuit_sub(in2, in0);
    let t1 = circuit_inverse(t0);
    let t2 = circuit_mul(in1, in2);

    let modulus = get_GRUMPKIN_modulus(); // GRUMPKIN prime field modulus

    let mut circuit_inputs = (t1, t2).new_inputs();
    // Prefill constants:
    circuit_inputs = circuit_inputs.next_2([0x1, 0x0, 0x0, 0x0]); // in0
    circuit_inputs = circuit_inputs
        .next_2(
            [0x8712848a692c553d0329f5d6, 0x64751ad938e2b5e6a54cf8c6, 0x204bd3277422fad3, 0x0],
        ); // in1
    // Fill inputs:
    circuit_inputs = circuit_inputs.next_2(tp_gemini_r); // in2

    let outputs = circuit_inputs.done_2().eval(modulus).unwrap();
    let challenge_poly_eval: u384 = outputs.get_output(t1);
    let root_power_times_tp_gemini_r: u384 = outputs.get_output(t2);
    return (challenge_poly_eval, root_power_times_tp_gemini_r);
}
#[inline(always)]
pub fn run_GRUMPKIN_ZK_HONK_EVALS_CONS_LOOP_SIZE_7_circuit(
    challenge_poly_eval: u384, root_power_times_tp_gemini_r: u384, tp_sumcheck_u_challenge: u384,
) -> (u384, u384) {
    // CONSTANT stack
    let in0 = CE::<CI<0>> {}; // 0x1
    let in1 = CE::<CI<1>> {}; // 0x204bd3277422fad364751ad938e2b5e6a54cf8c68712848a692c553d0329f5d6

    // INPUT stack
    let (in2, in3, in4) = (CE::<CI<2>> {}, CE::<CI<3>> {}, CE::<CI<4>> {});
    let t0 = circuit_sub(in3, in0);
    let t1 = circuit_inverse(t0);
    let t2 = circuit_mul(in0, t1);
    let t3 = circuit_add(in2, t2);
    let t4 = circuit_mul(in3, in1);
    let t5 = circuit_mul(in0, in4);
    let t6 = circuit_sub(t4, in0);
    let t7 = circuit_inverse(t6);
    let t8 = circuit_mul(t5, t7);
    let t9 = circuit_add(t3, t8);
    let t10 = circuit_mul(t4, in1);
    let t11 = circuit_mul(t5, in4);
    let t12 = circuit_sub(t10, in0);
    let t13 = circuit_inverse(t12);
    let t14 = circuit_mul(t11, t13);
    let t15 = circuit_add(t9, t14);
    let t16 = circuit_mul(t10, in1);
    let t17 = circuit_mul(t11, in4);
    let t18 = circuit_sub(t16, in0);
    let t19 = circuit_inverse(t18);
    let t20 = circuit_mul(t17, t19);
    let t21 = circuit_add(t15, t20);
    let t22 = circuit_mul(t16, in1);
    let t23 = circuit_mul(t17, in4);
    let t24 = circuit_sub(t22, in0);
    let t25 = circuit_inverse(t24);
    let t26 = circuit_mul(t23, t25);
    let t27 = circuit_add(t21, t26);
    let t28 = circuit_mul(t22, in1);
    let t29 = circuit_mul(t23, in4);
    let t30 = circuit_sub(t28, in0);
    let t31 = circuit_inverse(t30);
    let t32 = circuit_mul(t29, t31);
    let t33 = circuit_add(t27, t32);
    let t34 = circuit_mul(t28, in1);
    let t35 = circuit_mul(t29, in4);
    let t36 = circuit_sub(t34, in0);
    let t37 = circuit_inverse(t36);
    let t38 = circuit_mul(t35, t37);
    let t39 = circuit_add(t33, t38);
    let t40 = circuit_mul(t34, in1);
    let t41 = circuit_mul(t35, in4);
    let t42 = circuit_sub(t40, in0);
    let t43 = circuit_inverse(t42);
    let t44 = circuit_mul(t41, t43);
    let t45 = circuit_add(t39, t44);
    let t46 = circuit_mul(t40, in1);
    let t47 = circuit_mul(t41, in4);
    let t48 = circuit_sub(t46, in0);
    let t49 = circuit_inverse(t48);
    let t50 = circuit_mul(t47, t49);
    let t51 = circuit_add(t45, t50);
    let t52 = circuit_mul(t46, in1);

    let modulus = get_GRUMPKIN_modulus(); // GRUMPKIN prime field modulus

    let mut circuit_inputs = (t51, t52).new_inputs();
    // Prefill constants:
    circuit_inputs = circuit_inputs.next_2([0x1, 0x0, 0x0, 0x0]); // in0
    circuit_inputs = circuit_inputs
        .next_2(
            [0x8712848a692c553d0329f5d6, 0x64751ad938e2b5e6a54cf8c6, 0x204bd3277422fad3, 0x0],
        ); // in1
    // Fill inputs:
    circuit_inputs = circuit_inputs.next_2(challenge_poly_eval); // in2
    circuit_inputs = circuit_inputs.next_2(root_power_times_tp_gemini_r); // in3
    circuit_inputs = circuit_inputs.next_2(tp_sumcheck_u_challenge); // in4

    let outputs = circuit_inputs.done_2().eval(modulus).unwrap();
    let challenge_poly_eval: u384 = outputs.get_output(t51);
    let root_power_times_tp_gemini_r: u384 = outputs.get_output(t52);
    return (challenge_poly_eval, root_power_times_tp_gemini_r);
}
#[inline(always)]
pub fn run_GRUMPKIN_ZK_HONK_EVALS_CONS_DONE_SIZE_7_circuit(
    p_libra_evaluation: u384,
    p_libra_poly_evals: Span<u256>,
    tp_gemini_r: u384,
    challenge_poly_eval: u384,
    root_power_times_tp_gemini_r: u384,
) -> (u384, u384) {
    // CONSTANT stack
    let in0 = CE::<CI<0>> {}; // 0x204bd3277422fad364751ad938e2b5e6a54cf8c68712848a692c553d0329f5d6
    let in1 = CE::<CI<1>> {}; // 0x1
    let in2 = CE::<CI<2>> {}; // 0x100

    // INPUT stack
    let (in3, in4, in5) = (CE::<CI<3>> {}, CE::<CI<4>> {}, CE::<CI<5>> {});
    let (in6, in7, in8) = (CE::<CI<6>> {}, CE::<CI<7>> {}, CE::<CI<8>> {});
    let (in9, in10) = (CE::<CI<9>> {}, CE::<CI<10>> {});
    let t0 = circuit_mul(in10, in0);
    let t1 = circuit_mul(t0, in0);
    let t2 = circuit_sub(in8, in1);
    let t3 = circuit_inverse(t2);
    let t4 = circuit_sub(t1, in1);
    let t5 = circuit_inverse(t4);
    let t6 = circuit_mul(in8, in8);
    let t7 = circuit_mul(t6, t6);
    let t8 = circuit_mul(t7, t7);
    let t9 = circuit_mul(t8, t8);
    let t10 = circuit_mul(t9, t9);
    let t11 = circuit_mul(t10, t10);
    let t12 = circuit_mul(t11, t11);
    let t13 = circuit_mul(t12, t12);
    let t14 = circuit_sub(t13, in1);
    let t15 = circuit_inverse(in2);
    let t16 = circuit_mul(t14, t15);
    let t17 = circuit_mul(in9, t16);
    let t18 = circuit_mul(t3, t16);
    let t19 = circuit_mul(t5, t16);
    let t20 = circuit_mul(t18, in6);
    let t21 = circuit_sub(in8, in0);
    let t22 = circuit_sub(in5, in6);
    let t23 = circuit_mul(in4, t17);
    let t24 = circuit_sub(t22, t23);
    let t25 = circuit_mul(t21, t24);
    let t26 = circuit_add(t20, t25);
    let t27 = circuit_sub(in6, in3);
    let t28 = circuit_mul(t19, t27);
    let t29 = circuit_add(t26, t28);
    let t30 = circuit_mul(t14, in7);
    let t31 = circuit_sub(t29, t30);

    let modulus = get_GRUMPKIN_modulus(); // GRUMPKIN prime field modulus

    let mut circuit_inputs = (t14, t31).new_inputs();
    // Prefill constants:
    circuit_inputs = circuit_inputs
        .next_2(
            [0x8712848a692c553d0329f5d6, 0x64751ad938e2b5e6a54cf8c6, 0x204bd3277422fad3, 0x0],
        ); // in0
    circuit_inputs = circuit_inputs.next_2([0x1, 0x0, 0x0, 0x0]); // in1
    circuit_inputs = circuit_inputs.next_2([0x100, 0x0, 0x0, 0x0]); // in2
    // Fill inputs:
    circuit_inputs = circuit_inputs.next_2(p_libra_evaluation); // in3

    for val in p_libra_poly_evals {
        circuit_inputs = circuit_inputs.next_u256(*val);
    } // in4 - in7

    circuit_inputs = circuit_inputs.next_2(tp_gemini_r); // in8
    circuit_inputs = circuit_inputs.next_2(challenge_poly_eval); // in9
    circuit_inputs = circuit_inputs.next_2(root_power_times_tp_gemini_r); // in10

    let outputs = circuit_inputs.done_2().eval(modulus).unwrap();
    let vanishing_check: u384 = outputs.get_output(t14);
    let diff_check: u384 = outputs.get_output(t31);
    return (vanishing_check, diff_check);
}
pub fn run_BN254_EVAL_FN_CHALLENGE_SING_47P_RLC_circuit(
    A: G1Point, coeff: u384, SumDlogDivBatched: FunctionFelt,
) -> (u384,) {
    // INPUT stack
    let (in0, in1, in2) = (CE::<CI<0>> {}, CE::<CI<1>> {}, CE::<CI<2>> {});
    let (in3, in4, in5) = (CE::<CI<3>> {}, CE::<CI<4>> {}, CE::<CI<5>> {});
    let (in6, in7, in8) = (CE::<CI<6>> {}, CE::<CI<7>> {}, CE::<CI<8>> {});
    let (in9, in10, in11) = (CE::<CI<9>> {}, CE::<CI<10>> {}, CE::<CI<11>> {});
    let (in12, in13, in14) = (CE::<CI<12>> {}, CE::<CI<13>> {}, CE::<CI<14>> {});
    let (in15, in16, in17) = (CE::<CI<15>> {}, CE::<CI<16>> {}, CE::<CI<17>> {});
    let (in18, in19, in20) = (CE::<CI<18>> {}, CE::<CI<19>> {}, CE::<CI<20>> {});
    let (in21, in22, in23) = (CE::<CI<21>> {}, CE::<CI<22>> {}, CE::<CI<23>> {});
    let (in24, in25, in26) = (CE::<CI<24>> {}, CE::<CI<25>> {}, CE::<CI<26>> {});
    let (in27, in28, in29) = (CE::<CI<27>> {}, CE::<CI<28>> {}, CE::<CI<29>> {});
    let (in30, in31, in32) = (CE::<CI<30>> {}, CE::<CI<31>> {}, CE::<CI<32>> {});
    let (in33, in34, in35) = (CE::<CI<33>> {}, CE::<CI<34>> {}, CE::<CI<35>> {});
    let (in36, in37, in38) = (CE::<CI<36>> {}, CE::<CI<37>> {}, CE::<CI<38>> {});
    let (in39, in40, in41) = (CE::<CI<39>> {}, CE::<CI<40>> {}, CE::<CI<41>> {});
    let (in42, in43, in44) = (CE::<CI<42>> {}, CE::<CI<43>> {}, CE::<CI<44>> {});
    let (in45, in46, in47) = (CE::<CI<45>> {}, CE::<CI<46>> {}, CE::<CI<47>> {});
    let (in48, in49, in50) = (CE::<CI<48>> {}, CE::<CI<49>> {}, CE::<CI<50>> {});
    let (in51, in52, in53) = (CE::<CI<51>> {}, CE::<CI<52>> {}, CE::<CI<53>> {});
    let (in54, in55, in56) = (CE::<CI<54>> {}, CE::<CI<55>> {}, CE::<CI<56>> {});
    let (in57, in58, in59) = (CE::<CI<57>> {}, CE::<CI<58>> {}, CE::<CI<59>> {});
    let (in60, in61, in62) = (CE::<CI<60>> {}, CE::<CI<61>> {}, CE::<CI<62>> {});
    let (in63, in64, in65) = (CE::<CI<63>> {}, CE::<CI<64>> {}, CE::<CI<65>> {});
    let (in66, in67, in68) = (CE::<CI<66>> {}, CE::<CI<67>> {}, CE::<CI<68>> {});
    let (in69, in70, in71) = (CE::<CI<69>> {}, CE::<CI<70>> {}, CE::<CI<71>> {});
    let (in72, in73, in74) = (CE::<CI<72>> {}, CE::<CI<73>> {}, CE::<CI<74>> {});
    let (in75, in76, in77) = (CE::<CI<75>> {}, CE::<CI<76>> {}, CE::<CI<77>> {});
    let (in78, in79, in80) = (CE::<CI<78>> {}, CE::<CI<79>> {}, CE::<CI<80>> {});
    let (in81, in82, in83) = (CE::<CI<81>> {}, CE::<CI<82>> {}, CE::<CI<83>> {});
    let (in84, in85, in86) = (CE::<CI<84>> {}, CE::<CI<85>> {}, CE::<CI<86>> {});
    let (in87, in88, in89) = (CE::<CI<87>> {}, CE::<CI<88>> {}, CE::<CI<89>> {});
    let (in90, in91, in92) = (CE::<CI<90>> {}, CE::<CI<91>> {}, CE::<CI<92>> {});
    let (in93, in94, in95) = (CE::<CI<93>> {}, CE::<CI<94>> {}, CE::<CI<95>> {});
    let (in96, in97, in98) = (CE::<CI<96>> {}, CE::<CI<97>> {}, CE::<CI<98>> {});
    let (in99, in100, in101) = (CE::<CI<99>> {}, CE::<CI<100>> {}, CE::<CI<101>> {});
    let (in102, in103, in104) = (CE::<CI<102>> {}, CE::<CI<103>> {}, CE::<CI<104>> {});
    let (in105, in106, in107) = (CE::<CI<105>> {}, CE::<CI<106>> {}, CE::<CI<107>> {});
    let (in108, in109, in110) = (CE::<CI<108>> {}, CE::<CI<109>> {}, CE::<CI<110>> {});
    let (in111, in112, in113) = (CE::<CI<111>> {}, CE::<CI<112>> {}, CE::<CI<113>> {});
    let (in114, in115, in116) = (CE::<CI<114>> {}, CE::<CI<115>> {}, CE::<CI<116>> {});
    let (in117, in118, in119) = (CE::<CI<117>> {}, CE::<CI<118>> {}, CE::<CI<119>> {});
    let (in120, in121, in122) = (CE::<CI<120>> {}, CE::<CI<121>> {}, CE::<CI<122>> {});
    let (in123, in124, in125) = (CE::<CI<123>> {}, CE::<CI<124>> {}, CE::<CI<125>> {});
    let (in126, in127, in128) = (CE::<CI<126>> {}, CE::<CI<127>> {}, CE::<CI<128>> {});
    let (in129, in130, in131) = (CE::<CI<129>> {}, CE::<CI<130>> {}, CE::<CI<131>> {});
    let (in132, in133, in134) = (CE::<CI<132>> {}, CE::<CI<133>> {}, CE::<CI<134>> {});
    let (in135, in136, in137) = (CE::<CI<135>> {}, CE::<CI<136>> {}, CE::<CI<137>> {});
    let (in138, in139, in140) = (CE::<CI<138>> {}, CE::<CI<139>> {}, CE::<CI<140>> {});
    let (in141, in142, in143) = (CE::<CI<141>> {}, CE::<CI<142>> {}, CE::<CI<143>> {});
    let (in144, in145, in146) = (CE::<CI<144>> {}, CE::<CI<145>> {}, CE::<CI<146>> {});
    let (in147, in148, in149) = (CE::<CI<147>> {}, CE::<CI<148>> {}, CE::<CI<149>> {});
    let (in150, in151, in152) = (CE::<CI<150>> {}, CE::<CI<151>> {}, CE::<CI<152>> {});
    let (in153, in154, in155) = (CE::<CI<153>> {}, CE::<CI<154>> {}, CE::<CI<155>> {});
    let (in156, in157, in158) = (CE::<CI<156>> {}, CE::<CI<157>> {}, CE::<CI<158>> {});
    let (in159, in160, in161) = (CE::<CI<159>> {}, CE::<CI<160>> {}, CE::<CI<161>> {});
    let (in162, in163, in164) = (CE::<CI<162>> {}, CE::<CI<163>> {}, CE::<CI<164>> {});
    let (in165, in166, in167) = (CE::<CI<165>> {}, CE::<CI<166>> {}, CE::<CI<167>> {});
    let (in168, in169, in170) = (CE::<CI<168>> {}, CE::<CI<169>> {}, CE::<CI<170>> {});
    let (in171, in172, in173) = (CE::<CI<171>> {}, CE::<CI<172>> {}, CE::<CI<173>> {});
    let (in174, in175, in176) = (CE::<CI<174>> {}, CE::<CI<175>> {}, CE::<CI<176>> {});
    let (in177, in178, in179) = (CE::<CI<177>> {}, CE::<CI<178>> {}, CE::<CI<179>> {});
    let (in180, in181, in182) = (CE::<CI<180>> {}, CE::<CI<181>> {}, CE::<CI<182>> {});
    let (in183, in184, in185) = (CE::<CI<183>> {}, CE::<CI<184>> {}, CE::<CI<185>> {});
    let (in186, in187, in188) = (CE::<CI<186>> {}, CE::<CI<187>> {}, CE::<CI<188>> {});
    let (in189, in190, in191) = (CE::<CI<189>> {}, CE::<CI<190>> {}, CE::<CI<191>> {});
    let (in192, in193, in194) = (CE::<CI<192>> {}, CE::<CI<193>> {}, CE::<CI<194>> {});
    let (in195, in196, in197) = (CE::<CI<195>> {}, CE::<CI<196>> {}, CE::<CI<197>> {});
    let (in198, in199, in200) = (CE::<CI<198>> {}, CE::<CI<199>> {}, CE::<CI<200>> {});
    let (in201, in202, in203) = (CE::<CI<201>> {}, CE::<CI<202>> {}, CE::<CI<203>> {});
    let (in204, in205, in206) = (CE::<CI<204>> {}, CE::<CI<205>> {}, CE::<CI<206>> {});
    let (in207, in208) = (CE::<CI<207>> {}, CE::<CI<208>> {});
    let t0 = circuit_mul(in52, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t1 = circuit_add(in51, t0); // Eval sumdlogdiv_a_num Horner step: add coefficient_48
    let t2 = circuit_mul(t1, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t3 = circuit_add(in50, t2); // Eval sumdlogdiv_a_num Horner step: add coefficient_47
    let t4 = circuit_mul(t3, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t5 = circuit_add(in49, t4); // Eval sumdlogdiv_a_num Horner step: add coefficient_46
    let t6 = circuit_mul(t5, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t7 = circuit_add(in48, t6); // Eval sumdlogdiv_a_num Horner step: add coefficient_45
    let t8 = circuit_mul(t7, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t9 = circuit_add(in47, t8); // Eval sumdlogdiv_a_num Horner step: add coefficient_44
    let t10 = circuit_mul(t9, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t11 = circuit_add(in46, t10); // Eval sumdlogdiv_a_num Horner step: add coefficient_43
    let t12 = circuit_mul(t11, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t13 = circuit_add(in45, t12); // Eval sumdlogdiv_a_num Horner step: add coefficient_42
    let t14 = circuit_mul(t13, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t15 = circuit_add(in44, t14); // Eval sumdlogdiv_a_num Horner step: add coefficient_41
    let t16 = circuit_mul(t15, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t17 = circuit_add(in43, t16); // Eval sumdlogdiv_a_num Horner step: add coefficient_40
    let t18 = circuit_mul(t17, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t19 = circuit_add(in42, t18); // Eval sumdlogdiv_a_num Horner step: add coefficient_39
    let t20 = circuit_mul(t19, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t21 = circuit_add(in41, t20); // Eval sumdlogdiv_a_num Horner step: add coefficient_38
    let t22 = circuit_mul(t21, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t23 = circuit_add(in40, t22); // Eval sumdlogdiv_a_num Horner step: add coefficient_37
    let t24 = circuit_mul(t23, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t25 = circuit_add(in39, t24); // Eval sumdlogdiv_a_num Horner step: add coefficient_36
    let t26 = circuit_mul(t25, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t27 = circuit_add(in38, t26); // Eval sumdlogdiv_a_num Horner step: add coefficient_35
    let t28 = circuit_mul(t27, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t29 = circuit_add(in37, t28); // Eval sumdlogdiv_a_num Horner step: add coefficient_34
    let t30 = circuit_mul(t29, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t31 = circuit_add(in36, t30); // Eval sumdlogdiv_a_num Horner step: add coefficient_33
    let t32 = circuit_mul(t31, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t33 = circuit_add(in35, t32); // Eval sumdlogdiv_a_num Horner step: add coefficient_32
    let t34 = circuit_mul(t33, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t35 = circuit_add(in34, t34); // Eval sumdlogdiv_a_num Horner step: add coefficient_31
    let t36 = circuit_mul(t35, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t37 = circuit_add(in33, t36); // Eval sumdlogdiv_a_num Horner step: add coefficient_30
    let t38 = circuit_mul(t37, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t39 = circuit_add(in32, t38); // Eval sumdlogdiv_a_num Horner step: add coefficient_29
    let t40 = circuit_mul(t39, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t41 = circuit_add(in31, t40); // Eval sumdlogdiv_a_num Horner step: add coefficient_28
    let t42 = circuit_mul(t41, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t43 = circuit_add(in30, t42); // Eval sumdlogdiv_a_num Horner step: add coefficient_27
    let t44 = circuit_mul(t43, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t45 = circuit_add(in29, t44); // Eval sumdlogdiv_a_num Horner step: add coefficient_26
    let t46 = circuit_mul(t45, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t47 = circuit_add(in28, t46); // Eval sumdlogdiv_a_num Horner step: add coefficient_25
    let t48 = circuit_mul(t47, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t49 = circuit_add(in27, t48); // Eval sumdlogdiv_a_num Horner step: add coefficient_24
    let t50 = circuit_mul(t49, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t51 = circuit_add(in26, t50); // Eval sumdlogdiv_a_num Horner step: add coefficient_23
    let t52 = circuit_mul(t51, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t53 = circuit_add(in25, t52); // Eval sumdlogdiv_a_num Horner step: add coefficient_22
    let t54 = circuit_mul(t53, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t55 = circuit_add(in24, t54); // Eval sumdlogdiv_a_num Horner step: add coefficient_21
    let t56 = circuit_mul(t55, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t57 = circuit_add(in23, t56); // Eval sumdlogdiv_a_num Horner step: add coefficient_20
    let t58 = circuit_mul(t57, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t59 = circuit_add(in22, t58); // Eval sumdlogdiv_a_num Horner step: add coefficient_19
    let t60 = circuit_mul(t59, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t61 = circuit_add(in21, t60); // Eval sumdlogdiv_a_num Horner step: add coefficient_18
    let t62 = circuit_mul(t61, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t63 = circuit_add(in20, t62); // Eval sumdlogdiv_a_num Horner step: add coefficient_17
    let t64 = circuit_mul(t63, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t65 = circuit_add(in19, t64); // Eval sumdlogdiv_a_num Horner step: add coefficient_16
    let t66 = circuit_mul(t65, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t67 = circuit_add(in18, t66); // Eval sumdlogdiv_a_num Horner step: add coefficient_15
    let t68 = circuit_mul(t67, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t69 = circuit_add(in17, t68); // Eval sumdlogdiv_a_num Horner step: add coefficient_14
    let t70 = circuit_mul(t69, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t71 = circuit_add(in16, t70); // Eval sumdlogdiv_a_num Horner step: add coefficient_13
    let t72 = circuit_mul(t71, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t73 = circuit_add(in15, t72); // Eval sumdlogdiv_a_num Horner step: add coefficient_12
    let t74 = circuit_mul(t73, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t75 = circuit_add(in14, t74); // Eval sumdlogdiv_a_num Horner step: add coefficient_11
    let t76 = circuit_mul(t75, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t77 = circuit_add(in13, t76); // Eval sumdlogdiv_a_num Horner step: add coefficient_10
    let t78 = circuit_mul(t77, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t79 = circuit_add(in12, t78); // Eval sumdlogdiv_a_num Horner step: add coefficient_9
    let t80 = circuit_mul(t79, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t81 = circuit_add(in11, t80); // Eval sumdlogdiv_a_num Horner step: add coefficient_8
    let t82 = circuit_mul(t81, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t83 = circuit_add(in10, t82); // Eval sumdlogdiv_a_num Horner step: add coefficient_7
    let t84 = circuit_mul(t83, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t85 = circuit_add(in9, t84); // Eval sumdlogdiv_a_num Horner step: add coefficient_6
    let t86 = circuit_mul(t85, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t87 = circuit_add(in8, t86); // Eval sumdlogdiv_a_num Horner step: add coefficient_5
    let t88 = circuit_mul(t87, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t89 = circuit_add(in7, t88); // Eval sumdlogdiv_a_num Horner step: add coefficient_4
    let t90 = circuit_mul(t89, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t91 = circuit_add(in6, t90); // Eval sumdlogdiv_a_num Horner step: add coefficient_3
    let t92 = circuit_mul(t91, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t93 = circuit_add(in5, t92); // Eval sumdlogdiv_a_num Horner step: add coefficient_2
    let t94 = circuit_mul(t93, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t95 = circuit_add(in4, t94); // Eval sumdlogdiv_a_num Horner step: add coefficient_1
    let t96 = circuit_mul(t95, in0); // Eval sumdlogdiv_a_num Horner step: multiply by xA
    let t97 = circuit_add(in3, t96); // Eval sumdlogdiv_a_num Horner step: add coefficient_0
    let t98 = circuit_mul(in103, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t99 = circuit_add(in102, t98); // Eval sumdlogdiv_a_den Horner step: add coefficient_49
    let t100 = circuit_mul(t99, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t101 = circuit_add(in101, t100); // Eval sumdlogdiv_a_den Horner step: add coefficient_48
    let t102 = circuit_mul(t101, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t103 = circuit_add(in100, t102); // Eval sumdlogdiv_a_den Horner step: add coefficient_47
    let t104 = circuit_mul(t103, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t105 = circuit_add(in99, t104); // Eval sumdlogdiv_a_den Horner step: add coefficient_46
    let t106 = circuit_mul(t105, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t107 = circuit_add(in98, t106); // Eval sumdlogdiv_a_den Horner step: add coefficient_45
    let t108 = circuit_mul(t107, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t109 = circuit_add(in97, t108); // Eval sumdlogdiv_a_den Horner step: add coefficient_44
    let t110 = circuit_mul(t109, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t111 = circuit_add(in96, t110); // Eval sumdlogdiv_a_den Horner step: add coefficient_43
    let t112 = circuit_mul(t111, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t113 = circuit_add(in95, t112); // Eval sumdlogdiv_a_den Horner step: add coefficient_42
    let t114 = circuit_mul(t113, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t115 = circuit_add(in94, t114); // Eval sumdlogdiv_a_den Horner step: add coefficient_41
    let t116 = circuit_mul(t115, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t117 = circuit_add(in93, t116); // Eval sumdlogdiv_a_den Horner step: add coefficient_40
    let t118 = circuit_mul(t117, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t119 = circuit_add(in92, t118); // Eval sumdlogdiv_a_den Horner step: add coefficient_39
    let t120 = circuit_mul(t119, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t121 = circuit_add(in91, t120); // Eval sumdlogdiv_a_den Horner step: add coefficient_38
    let t122 = circuit_mul(t121, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t123 = circuit_add(in90, t122); // Eval sumdlogdiv_a_den Horner step: add coefficient_37
    let t124 = circuit_mul(t123, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t125 = circuit_add(in89, t124); // Eval sumdlogdiv_a_den Horner step: add coefficient_36
    let t126 = circuit_mul(t125, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t127 = circuit_add(in88, t126); // Eval sumdlogdiv_a_den Horner step: add coefficient_35
    let t128 = circuit_mul(t127, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t129 = circuit_add(in87, t128); // Eval sumdlogdiv_a_den Horner step: add coefficient_34
    let t130 = circuit_mul(t129, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t131 = circuit_add(in86, t130); // Eval sumdlogdiv_a_den Horner step: add coefficient_33
    let t132 = circuit_mul(t131, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t133 = circuit_add(in85, t132); // Eval sumdlogdiv_a_den Horner step: add coefficient_32
    let t134 = circuit_mul(t133, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t135 = circuit_add(in84, t134); // Eval sumdlogdiv_a_den Horner step: add coefficient_31
    let t136 = circuit_mul(t135, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t137 = circuit_add(in83, t136); // Eval sumdlogdiv_a_den Horner step: add coefficient_30
    let t138 = circuit_mul(t137, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t139 = circuit_add(in82, t138); // Eval sumdlogdiv_a_den Horner step: add coefficient_29
    let t140 = circuit_mul(t139, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t141 = circuit_add(in81, t140); // Eval sumdlogdiv_a_den Horner step: add coefficient_28
    let t142 = circuit_mul(t141, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t143 = circuit_add(in80, t142); // Eval sumdlogdiv_a_den Horner step: add coefficient_27
    let t144 = circuit_mul(t143, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t145 = circuit_add(in79, t144); // Eval sumdlogdiv_a_den Horner step: add coefficient_26
    let t146 = circuit_mul(t145, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t147 = circuit_add(in78, t146); // Eval sumdlogdiv_a_den Horner step: add coefficient_25
    let t148 = circuit_mul(t147, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t149 = circuit_add(in77, t148); // Eval sumdlogdiv_a_den Horner step: add coefficient_24
    let t150 = circuit_mul(t149, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t151 = circuit_add(in76, t150); // Eval sumdlogdiv_a_den Horner step: add coefficient_23
    let t152 = circuit_mul(t151, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t153 = circuit_add(in75, t152); // Eval sumdlogdiv_a_den Horner step: add coefficient_22
    let t154 = circuit_mul(t153, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t155 = circuit_add(in74, t154); // Eval sumdlogdiv_a_den Horner step: add coefficient_21
    let t156 = circuit_mul(t155, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t157 = circuit_add(in73, t156); // Eval sumdlogdiv_a_den Horner step: add coefficient_20
    let t158 = circuit_mul(t157, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t159 = circuit_add(in72, t158); // Eval sumdlogdiv_a_den Horner step: add coefficient_19
    let t160 = circuit_mul(t159, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t161 = circuit_add(in71, t160); // Eval sumdlogdiv_a_den Horner step: add coefficient_18
    let t162 = circuit_mul(t161, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t163 = circuit_add(in70, t162); // Eval sumdlogdiv_a_den Horner step: add coefficient_17
    let t164 = circuit_mul(t163, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t165 = circuit_add(in69, t164); // Eval sumdlogdiv_a_den Horner step: add coefficient_16
    let t166 = circuit_mul(t165, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t167 = circuit_add(in68, t166); // Eval sumdlogdiv_a_den Horner step: add coefficient_15
    let t168 = circuit_mul(t167, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t169 = circuit_add(in67, t168); // Eval sumdlogdiv_a_den Horner step: add coefficient_14
    let t170 = circuit_mul(t169, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t171 = circuit_add(in66, t170); // Eval sumdlogdiv_a_den Horner step: add coefficient_13
    let t172 = circuit_mul(t171, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t173 = circuit_add(in65, t172); // Eval sumdlogdiv_a_den Horner step: add coefficient_12
    let t174 = circuit_mul(t173, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t175 = circuit_add(in64, t174); // Eval sumdlogdiv_a_den Horner step: add coefficient_11
    let t176 = circuit_mul(t175, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t177 = circuit_add(in63, t176); // Eval sumdlogdiv_a_den Horner step: add coefficient_10
    let t178 = circuit_mul(t177, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t179 = circuit_add(in62, t178); // Eval sumdlogdiv_a_den Horner step: add coefficient_9
    let t180 = circuit_mul(t179, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t181 = circuit_add(in61, t180); // Eval sumdlogdiv_a_den Horner step: add coefficient_8
    let t182 = circuit_mul(t181, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t183 = circuit_add(in60, t182); // Eval sumdlogdiv_a_den Horner step: add coefficient_7
    let t184 = circuit_mul(t183, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t185 = circuit_add(in59, t184); // Eval sumdlogdiv_a_den Horner step: add coefficient_6
    let t186 = circuit_mul(t185, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t187 = circuit_add(in58, t186); // Eval sumdlogdiv_a_den Horner step: add coefficient_5
    let t188 = circuit_mul(t187, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t189 = circuit_add(in57, t188); // Eval sumdlogdiv_a_den Horner step: add coefficient_4
    let t190 = circuit_mul(t189, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t191 = circuit_add(in56, t190); // Eval sumdlogdiv_a_den Horner step: add coefficient_3
    let t192 = circuit_mul(t191, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t193 = circuit_add(in55, t192); // Eval sumdlogdiv_a_den Horner step: add coefficient_2
    let t194 = circuit_mul(t193, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t195 = circuit_add(in54, t194); // Eval sumdlogdiv_a_den Horner step: add coefficient_1
    let t196 = circuit_mul(t195, in0); // Eval sumdlogdiv_a_den Horner step: multiply by xA
    let t197 = circuit_add(in53, t196); // Eval sumdlogdiv_a_den Horner step: add coefficient_0
    let t198 = circuit_inverse(t197);
    let t199 = circuit_mul(t97, t198);
    let t200 = circuit_mul(in154, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t201 = circuit_add(in153, t200); // Eval sumdlogdiv_b_num Horner step: add coefficient_49
    let t202 = circuit_mul(t201, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t203 = circuit_add(in152, t202); // Eval sumdlogdiv_b_num Horner step: add coefficient_48
    let t204 = circuit_mul(t203, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t205 = circuit_add(in151, t204); // Eval sumdlogdiv_b_num Horner step: add coefficient_47
    let t206 = circuit_mul(t205, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t207 = circuit_add(in150, t206); // Eval sumdlogdiv_b_num Horner step: add coefficient_46
    let t208 = circuit_mul(t207, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t209 = circuit_add(in149, t208); // Eval sumdlogdiv_b_num Horner step: add coefficient_45
    let t210 = circuit_mul(t209, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t211 = circuit_add(in148, t210); // Eval sumdlogdiv_b_num Horner step: add coefficient_44
    let t212 = circuit_mul(t211, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t213 = circuit_add(in147, t212); // Eval sumdlogdiv_b_num Horner step: add coefficient_43
    let t214 = circuit_mul(t213, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t215 = circuit_add(in146, t214); // Eval sumdlogdiv_b_num Horner step: add coefficient_42
    let t216 = circuit_mul(t215, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t217 = circuit_add(in145, t216); // Eval sumdlogdiv_b_num Horner step: add coefficient_41
    let t218 = circuit_mul(t217, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t219 = circuit_add(in144, t218); // Eval sumdlogdiv_b_num Horner step: add coefficient_40
    let t220 = circuit_mul(t219, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t221 = circuit_add(in143, t220); // Eval sumdlogdiv_b_num Horner step: add coefficient_39
    let t222 = circuit_mul(t221, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t223 = circuit_add(in142, t222); // Eval sumdlogdiv_b_num Horner step: add coefficient_38
    let t224 = circuit_mul(t223, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t225 = circuit_add(in141, t224); // Eval sumdlogdiv_b_num Horner step: add coefficient_37
    let t226 = circuit_mul(t225, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t227 = circuit_add(in140, t226); // Eval sumdlogdiv_b_num Horner step: add coefficient_36
    let t228 = circuit_mul(t227, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t229 = circuit_add(in139, t228); // Eval sumdlogdiv_b_num Horner step: add coefficient_35
    let t230 = circuit_mul(t229, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t231 = circuit_add(in138, t230); // Eval sumdlogdiv_b_num Horner step: add coefficient_34
    let t232 = circuit_mul(t231, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t233 = circuit_add(in137, t232); // Eval sumdlogdiv_b_num Horner step: add coefficient_33
    let t234 = circuit_mul(t233, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t235 = circuit_add(in136, t234); // Eval sumdlogdiv_b_num Horner step: add coefficient_32
    let t236 = circuit_mul(t235, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t237 = circuit_add(in135, t236); // Eval sumdlogdiv_b_num Horner step: add coefficient_31
    let t238 = circuit_mul(t237, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t239 = circuit_add(in134, t238); // Eval sumdlogdiv_b_num Horner step: add coefficient_30
    let t240 = circuit_mul(t239, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t241 = circuit_add(in133, t240); // Eval sumdlogdiv_b_num Horner step: add coefficient_29
    let t242 = circuit_mul(t241, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t243 = circuit_add(in132, t242); // Eval sumdlogdiv_b_num Horner step: add coefficient_28
    let t244 = circuit_mul(t243, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t245 = circuit_add(in131, t244); // Eval sumdlogdiv_b_num Horner step: add coefficient_27
    let t246 = circuit_mul(t245, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t247 = circuit_add(in130, t246); // Eval sumdlogdiv_b_num Horner step: add coefficient_26
    let t248 = circuit_mul(t247, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t249 = circuit_add(in129, t248); // Eval sumdlogdiv_b_num Horner step: add coefficient_25
    let t250 = circuit_mul(t249, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t251 = circuit_add(in128, t250); // Eval sumdlogdiv_b_num Horner step: add coefficient_24
    let t252 = circuit_mul(t251, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t253 = circuit_add(in127, t252); // Eval sumdlogdiv_b_num Horner step: add coefficient_23
    let t254 = circuit_mul(t253, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t255 = circuit_add(in126, t254); // Eval sumdlogdiv_b_num Horner step: add coefficient_22
    let t256 = circuit_mul(t255, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t257 = circuit_add(in125, t256); // Eval sumdlogdiv_b_num Horner step: add coefficient_21
    let t258 = circuit_mul(t257, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t259 = circuit_add(in124, t258); // Eval sumdlogdiv_b_num Horner step: add coefficient_20
    let t260 = circuit_mul(t259, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t261 = circuit_add(in123, t260); // Eval sumdlogdiv_b_num Horner step: add coefficient_19
    let t262 = circuit_mul(t261, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t263 = circuit_add(in122, t262); // Eval sumdlogdiv_b_num Horner step: add coefficient_18
    let t264 = circuit_mul(t263, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t265 = circuit_add(in121, t264); // Eval sumdlogdiv_b_num Horner step: add coefficient_17
    let t266 = circuit_mul(t265, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t267 = circuit_add(in120, t266); // Eval sumdlogdiv_b_num Horner step: add coefficient_16
    let t268 = circuit_mul(t267, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t269 = circuit_add(in119, t268); // Eval sumdlogdiv_b_num Horner step: add coefficient_15
    let t270 = circuit_mul(t269, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t271 = circuit_add(in118, t270); // Eval sumdlogdiv_b_num Horner step: add coefficient_14
    let t272 = circuit_mul(t271, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t273 = circuit_add(in117, t272); // Eval sumdlogdiv_b_num Horner step: add coefficient_13
    let t274 = circuit_mul(t273, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t275 = circuit_add(in116, t274); // Eval sumdlogdiv_b_num Horner step: add coefficient_12
    let t276 = circuit_mul(t275, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t277 = circuit_add(in115, t276); // Eval sumdlogdiv_b_num Horner step: add coefficient_11
    let t278 = circuit_mul(t277, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t279 = circuit_add(in114, t278); // Eval sumdlogdiv_b_num Horner step: add coefficient_10
    let t280 = circuit_mul(t279, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t281 = circuit_add(in113, t280); // Eval sumdlogdiv_b_num Horner step: add coefficient_9
    let t282 = circuit_mul(t281, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t283 = circuit_add(in112, t282); // Eval sumdlogdiv_b_num Horner step: add coefficient_8
    let t284 = circuit_mul(t283, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t285 = circuit_add(in111, t284); // Eval sumdlogdiv_b_num Horner step: add coefficient_7
    let t286 = circuit_mul(t285, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t287 = circuit_add(in110, t286); // Eval sumdlogdiv_b_num Horner step: add coefficient_6
    let t288 = circuit_mul(t287, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t289 = circuit_add(in109, t288); // Eval sumdlogdiv_b_num Horner step: add coefficient_5
    let t290 = circuit_mul(t289, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t291 = circuit_add(in108, t290); // Eval sumdlogdiv_b_num Horner step: add coefficient_4
    let t292 = circuit_mul(t291, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t293 = circuit_add(in107, t292); // Eval sumdlogdiv_b_num Horner step: add coefficient_3
    let t294 = circuit_mul(t293, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t295 = circuit_add(in106, t294); // Eval sumdlogdiv_b_num Horner step: add coefficient_2
    let t296 = circuit_mul(t295, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t297 = circuit_add(in105, t296); // Eval sumdlogdiv_b_num Horner step: add coefficient_1
    let t298 = circuit_mul(t297, in0); // Eval sumdlogdiv_b_num Horner step: multiply by xA
    let t299 = circuit_add(in104, t298); // Eval sumdlogdiv_b_num Horner step: add coefficient_0
    let t300 = circuit_mul(in208, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t301 = circuit_add(in207, t300); // Eval sumdlogdiv_b_den Horner step: add coefficient_52
    let t302 = circuit_mul(t301, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t303 = circuit_add(in206, t302); // Eval sumdlogdiv_b_den Horner step: add coefficient_51
    let t304 = circuit_mul(t303, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t305 = circuit_add(in205, t304); // Eval sumdlogdiv_b_den Horner step: add coefficient_50
    let t306 = circuit_mul(t305, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t307 = circuit_add(in204, t306); // Eval sumdlogdiv_b_den Horner step: add coefficient_49
    let t308 = circuit_mul(t307, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t309 = circuit_add(in203, t308); // Eval sumdlogdiv_b_den Horner step: add coefficient_48
    let t310 = circuit_mul(t309, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t311 = circuit_add(in202, t310); // Eval sumdlogdiv_b_den Horner step: add coefficient_47
    let t312 = circuit_mul(t311, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t313 = circuit_add(in201, t312); // Eval sumdlogdiv_b_den Horner step: add coefficient_46
    let t314 = circuit_mul(t313, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t315 = circuit_add(in200, t314); // Eval sumdlogdiv_b_den Horner step: add coefficient_45
    let t316 = circuit_mul(t315, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t317 = circuit_add(in199, t316); // Eval sumdlogdiv_b_den Horner step: add coefficient_44
    let t318 = circuit_mul(t317, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t319 = circuit_add(in198, t318); // Eval sumdlogdiv_b_den Horner step: add coefficient_43
    let t320 = circuit_mul(t319, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t321 = circuit_add(in197, t320); // Eval sumdlogdiv_b_den Horner step: add coefficient_42
    let t322 = circuit_mul(t321, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t323 = circuit_add(in196, t322); // Eval sumdlogdiv_b_den Horner step: add coefficient_41
    let t324 = circuit_mul(t323, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t325 = circuit_add(in195, t324); // Eval sumdlogdiv_b_den Horner step: add coefficient_40
    let t326 = circuit_mul(t325, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t327 = circuit_add(in194, t326); // Eval sumdlogdiv_b_den Horner step: add coefficient_39
    let t328 = circuit_mul(t327, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t329 = circuit_add(in193, t328); // Eval sumdlogdiv_b_den Horner step: add coefficient_38
    let t330 = circuit_mul(t329, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t331 = circuit_add(in192, t330); // Eval sumdlogdiv_b_den Horner step: add coefficient_37
    let t332 = circuit_mul(t331, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t333 = circuit_add(in191, t332); // Eval sumdlogdiv_b_den Horner step: add coefficient_36
    let t334 = circuit_mul(t333, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t335 = circuit_add(in190, t334); // Eval sumdlogdiv_b_den Horner step: add coefficient_35
    let t336 = circuit_mul(t335, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t337 = circuit_add(in189, t336); // Eval sumdlogdiv_b_den Horner step: add coefficient_34
    let t338 = circuit_mul(t337, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t339 = circuit_add(in188, t338); // Eval sumdlogdiv_b_den Horner step: add coefficient_33
    let t340 = circuit_mul(t339, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t341 = circuit_add(in187, t340); // Eval sumdlogdiv_b_den Horner step: add coefficient_32
    let t342 = circuit_mul(t341, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t343 = circuit_add(in186, t342); // Eval sumdlogdiv_b_den Horner step: add coefficient_31
    let t344 = circuit_mul(t343, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t345 = circuit_add(in185, t344); // Eval sumdlogdiv_b_den Horner step: add coefficient_30
    let t346 = circuit_mul(t345, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t347 = circuit_add(in184, t346); // Eval sumdlogdiv_b_den Horner step: add coefficient_29
    let t348 = circuit_mul(t347, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t349 = circuit_add(in183, t348); // Eval sumdlogdiv_b_den Horner step: add coefficient_28
    let t350 = circuit_mul(t349, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t351 = circuit_add(in182, t350); // Eval sumdlogdiv_b_den Horner step: add coefficient_27
    let t352 = circuit_mul(t351, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t353 = circuit_add(in181, t352); // Eval sumdlogdiv_b_den Horner step: add coefficient_26
    let t354 = circuit_mul(t353, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t355 = circuit_add(in180, t354); // Eval sumdlogdiv_b_den Horner step: add coefficient_25
    let t356 = circuit_mul(t355, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t357 = circuit_add(in179, t356); // Eval sumdlogdiv_b_den Horner step: add coefficient_24
    let t358 = circuit_mul(t357, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t359 = circuit_add(in178, t358); // Eval sumdlogdiv_b_den Horner step: add coefficient_23
    let t360 = circuit_mul(t359, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t361 = circuit_add(in177, t360); // Eval sumdlogdiv_b_den Horner step: add coefficient_22
    let t362 = circuit_mul(t361, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t363 = circuit_add(in176, t362); // Eval sumdlogdiv_b_den Horner step: add coefficient_21
    let t364 = circuit_mul(t363, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t365 = circuit_add(in175, t364); // Eval sumdlogdiv_b_den Horner step: add coefficient_20
    let t366 = circuit_mul(t365, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t367 = circuit_add(in174, t366); // Eval sumdlogdiv_b_den Horner step: add coefficient_19
    let t368 = circuit_mul(t367, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t369 = circuit_add(in173, t368); // Eval sumdlogdiv_b_den Horner step: add coefficient_18
    let t370 = circuit_mul(t369, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t371 = circuit_add(in172, t370); // Eval sumdlogdiv_b_den Horner step: add coefficient_17
    let t372 = circuit_mul(t371, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t373 = circuit_add(in171, t372); // Eval sumdlogdiv_b_den Horner step: add coefficient_16
    let t374 = circuit_mul(t373, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t375 = circuit_add(in170, t374); // Eval sumdlogdiv_b_den Horner step: add coefficient_15
    let t376 = circuit_mul(t375, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t377 = circuit_add(in169, t376); // Eval sumdlogdiv_b_den Horner step: add coefficient_14
    let t378 = circuit_mul(t377, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t379 = circuit_add(in168, t378); // Eval sumdlogdiv_b_den Horner step: add coefficient_13
    let t380 = circuit_mul(t379, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t381 = circuit_add(in167, t380); // Eval sumdlogdiv_b_den Horner step: add coefficient_12
    let t382 = circuit_mul(t381, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t383 = circuit_add(in166, t382); // Eval sumdlogdiv_b_den Horner step: add coefficient_11
    let t384 = circuit_mul(t383, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t385 = circuit_add(in165, t384); // Eval sumdlogdiv_b_den Horner step: add coefficient_10
    let t386 = circuit_mul(t385, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t387 = circuit_add(in164, t386); // Eval sumdlogdiv_b_den Horner step: add coefficient_9
    let t388 = circuit_mul(t387, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t389 = circuit_add(in163, t388); // Eval sumdlogdiv_b_den Horner step: add coefficient_8
    let t390 = circuit_mul(t389, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t391 = circuit_add(in162, t390); // Eval sumdlogdiv_b_den Horner step: add coefficient_7
    let t392 = circuit_mul(t391, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t393 = circuit_add(in161, t392); // Eval sumdlogdiv_b_den Horner step: add coefficient_6
    let t394 = circuit_mul(t393, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t395 = circuit_add(in160, t394); // Eval sumdlogdiv_b_den Horner step: add coefficient_5
    let t396 = circuit_mul(t395, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t397 = circuit_add(in159, t396); // Eval sumdlogdiv_b_den Horner step: add coefficient_4
    let t398 = circuit_mul(t397, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t399 = circuit_add(in158, t398); // Eval sumdlogdiv_b_den Horner step: add coefficient_3
    let t400 = circuit_mul(t399, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t401 = circuit_add(in157, t400); // Eval sumdlogdiv_b_den Horner step: add coefficient_2
    let t402 = circuit_mul(t401, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t403 = circuit_add(in156, t402); // Eval sumdlogdiv_b_den Horner step: add coefficient_1
    let t404 = circuit_mul(t403, in0); // Eval sumdlogdiv_b_den Horner step: multiply by xA
    let t405 = circuit_add(in155, t404); // Eval sumdlogdiv_b_den Horner step: add coefficient_0
    let t406 = circuit_inverse(t405);
    let t407 = circuit_mul(t299, t406);
    let t408 = circuit_mul(in1, t407);
    let t409 = circuit_add(t199, t408);
    let t410 = circuit_mul(in2, t409);

    let modulus = get_BN254_modulus(); // BN254 prime field modulus

    let mut circuit_inputs = (t410,).new_inputs();
    // Prefill constants:

    // Fill inputs:
    circuit_inputs = circuit_inputs.next_2(A.x); // in0
    circuit_inputs = circuit_inputs.next_2(A.y); // in1
    circuit_inputs = circuit_inputs.next_2(coeff); // in2

    for val in SumDlogDivBatched.a_num {
        circuit_inputs = circuit_inputs.next_2(*val);
    }

    for val in SumDlogDivBatched.a_den {
        circuit_inputs = circuit_inputs.next_2(*val);
    }

    for val in SumDlogDivBatched.b_num {
        circuit_inputs = circuit_inputs.next_2(*val);
    }

    for val in SumDlogDivBatched.b_den {
        circuit_inputs = circuit_inputs.next_2(*val);
    }
    // in3 - in208

    let outputs = circuit_inputs.done_2().eval(modulus).unwrap();
    let res: u384 = outputs.get_output(t410);
    return (res,);
}

impl CircuitDefinition46<
    E0,
    E1,
    E2,
    E3,
    E4,
    E5,
    E6,
    E7,
    E8,
    E9,
    E10,
    E11,
    E12,
    E13,
    E14,
    E15,
    E16,
    E17,
    E18,
    E19,
    E20,
    E21,
    E22,
    E23,
    E24,
    E25,
    E26,
    E27,
    E28,
    E29,
    E30,
    E31,
    E32,
    E33,
    E34,
    E35,
    E36,
    E37,
    E38,
    E39,
    E40,
    E41,
    E42,
    E43,
    E44,
    E45,
> of core::circuit::CircuitDefinition<
    (
        CE<E0>,
        CE<E1>,
        CE<E2>,
        CE<E3>,
        CE<E4>,
        CE<E5>,
        CE<E6>,
        CE<E7>,
        CE<E8>,
        CE<E9>,
        CE<E10>,
        CE<E11>,
        CE<E12>,
        CE<E13>,
        CE<E14>,
        CE<E15>,
        CE<E16>,
        CE<E17>,
        CE<E18>,
        CE<E19>,
        CE<E20>,
        CE<E21>,
        CE<E22>,
        CE<E23>,
        CE<E24>,
        CE<E25>,
        CE<E26>,
        CE<E27>,
        CE<E28>,
        CE<E29>,
        CE<E30>,
        CE<E31>,
        CE<E32>,
        CE<E33>,
        CE<E34>,
        CE<E35>,
        CE<E36>,
        CE<E37>,
        CE<E38>,
        CE<E39>,
        CE<E40>,
        CE<E41>,
        CE<E42>,
        CE<E43>,
        CE<E44>,
        CE<E45>,
    ),
> {
    type CircuitType =
        core::circuit::Circuit<
            (
                E0,
                E1,
                E2,
                E3,
                E4,
                E5,
                E6,
                E7,
                E8,
                E9,
                E10,
                E11,
                E12,
                E13,
                E14,
                E15,
                E16,
                E17,
                E18,
                E19,
                E20,
                E21,
                E22,
                E23,
                E24,
                E25,
                E26,
                E27,
                E28,
                E29,
                E30,
                E31,
                E32,
                E33,
                E34,
                E35,
                E36,
                E37,
                E38,
                E39,
                E40,
                E41,
                E42,
                E43,
                E44,
                E45,
            ),
        >;
}
impl MyDrp_46<
    E0,
    E1,
    E2,
    E3,
    E4,
    E5,
    E6,
    E7,
    E8,
    E9,
    E10,
    E11,
    E12,
    E13,
    E14,
    E15,
    E16,
    E17,
    E18,
    E19,
    E20,
    E21,
    E22,
    E23,
    E24,
    E25,
    E26,
    E27,
    E28,
    E29,
    E30,
    E31,
    E32,
    E33,
    E34,
    E35,
    E36,
    E37,
    E38,
    E39,
    E40,
    E41,
    E42,
    E43,
    E44,
    E45,
> of Drop<
    (
        CE<E0>,
        CE<E1>,
        CE<E2>,
        CE<E3>,
        CE<E4>,
        CE<E5>,
        CE<E6>,
        CE<E7>,
        CE<E8>,
        CE<E9>,
        CE<E10>,
        CE<E11>,
        CE<E12>,
        CE<E13>,
        CE<E14>,
        CE<E15>,
        CE<E16>,
        CE<E17>,
        CE<E18>,
        CE<E19>,
        CE<E20>,
        CE<E21>,
        CE<E22>,
        CE<E23>,
        CE<E24>,
        CE<E25>,
        CE<E26>,
        CE<E27>,
        CE<E28>,
        CE<E29>,
        CE<E30>,
        CE<E31>,
        CE<E32>,
        CE<E33>,
        CE<E34>,
        CE<E35>,
        CE<E36>,
        CE<E37>,
        CE<E38>,
        CE<E39>,
        CE<E40>,
        CE<E41>,
        CE<E42>,
        CE<E43>,
        CE<E44>,
        CE<E45>,
    ),
>;

