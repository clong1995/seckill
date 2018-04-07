package org.seckill.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.seckill.dto.Exposer;
import org.seckill.dto.SeckillExecution;
import org.seckill.entity.Seckill;
import org.seckill.exception.RepeateKillException;
import org.seckill.exception.SeckillCloseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

import static org.junit.Assert.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:spring/spring-dao.xml", "classpath:spring/spring-service.xml"})
public class SeckillServiceTest {
    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private SeckillService seckillService;

    @Test
    public void getSeckillList() {
        List<Seckill> list = seckillService.getSeckillList();
        logger.info("list={}", list);
    }

    @Test
    public void getSeckillById() {
        long id = 1000L;
        Seckill seckill = seckillService.getSeckillById(id);
        logger.info("seckill={}", seckill);
    }

    /*@Test
    public void exportSeckillUrl() {
        long id = 1000L;
        Exposer exposer = seckillService.exportSeckillUrl(id);
        logger.info("exposer={}", exposer);
    }

    @Test
    public void executeSeckill() {
        long id = 1000L;
        long userPhone = 15166077281L;
        String md5 = "e2e776a095bed08d0dd05e84f4cb83c8";
        try {
            SeckillExecution seckillExecution = seckillService.executeSeckill(id, userPhone, md5);
            logger.info("seckillExecution={}", seckillExecution);
        } catch (RepeateKillException rke) {
            logger.error(rke.getMessage(), rke);
        } catch (SeckillCloseException sce) {
            logger.error(sce.getMessage(), sce);
        }
    }*/

    @Test
    public void testSeckillLogic() {
        long id = 1000L;
        Exposer exposer = seckillService.exportSeckillUrl(id);
        if (exposer.isExposed()) {
            logger.info("exposer={}", exposer);
            long userPhone = 15166077288L;
            String md5 = exposer.getMd5();
            try {
                SeckillExecution seckillExecution = seckillService.executeSeckill(id, userPhone, md5);
                logger.info("seckillExecution={}", seckillExecution);
            } catch (RepeateKillException rke) {
                logger.error(rke.getMessage(), rke);
            } catch (SeckillCloseException sce) {
                logger.error(sce.getMessage(), sce);
            }
        } else {
            logger.warn("exposer={}", exposer);
        }
    }

    @Test
    public void testExecuteSeckillProcedure() {
        long seckillId = 1000L;
        long phone = 15166077170L;
        Exposer exposer = seckillService.exportSeckillUrl(seckillId);
        if (exposer.isExposed()) {
            String md5 = exposer.getMd5();
            SeckillExecution execution = seckillService.executeSeckillProcedure(seckillId, phone, md5);
            logger.info(execution.getStateInfo());
        }
    }
}