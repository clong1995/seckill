package org.seckill.service;

import org.seckill.dto.Exposer;
import org.seckill.dto.SeckillExecution;
import org.seckill.entity.Seckill;
import org.seckill.exception.RepeateKillException;
import org.seckill.exception.SeckillCloseException;
import org.seckill.exception.SeckillException;

import java.util.List;

public interface SeckillService {

    /**
     * 查询所有秒杀
     *
     * @return
     */
    List<Seckill> getSeckillList();

    /**
     * 查询单个秒杀
     *
     * @param seckillId
     * @return
     */
    Seckill getSeckillById(long seckillId);

    /**
     * 输出秒杀地址，否则输出系统时间和秒杀时间
     *
     * @param seckillId
     */
    Exposer exportSeckillUrl(long seckillId);

    /**
     * 执行秒杀
     *
     * @param seckillId
     * @param userPhone
     * @param md5
     */
    SeckillExecution executeSeckill(long seckillId, long userPhone, String md5)
            throws SeckillException, RepeateKillException, SeckillCloseException;

    /**
     * 执行秒杀存储过程
     *
     * @param seckillId
     * @param userPhone
     * @param md5
     */
    SeckillExecution executeSeckillProcedure(long seckillId, long userPhone, String md5);
}
